//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var jobInfos = [JobInfoViewModel]()
    var filteredJobInfos = [JobInfoViewModel]()
    var checkedStatus = [String]()
    var viewAll = true
    
    var profileSettings: ProfileSettingsViewModel?
    
    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    private var addButton: CircleButton!
    
    private var profileSectionView: ProfileSectionView!

    private var profileImage: ProfileImageView!
    private var greetLabel: UILabel!
    private var titleLabel: UILabel!
    
    private var tilesView: UIView!
    private var viewAllButton: AllFavoritesButton!
    private var viewFavoritesButton: AllFavoritesButton!
    
    private var noJobsView: NotFoundWithImageView!
    private var noFavsView: NotFoundWithImageView!


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)        
    }
    
    private func setJobInfosAndStatus() {
        JobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs {
                let createdJobInfoVMs = jobs.map{JobInfoViewModel(jobInfo: $0)}
                jobInfos = createdJobInfoVMs
                filteredJobInfos = jobInfos
                
                DispatchQueue.main.async { [weak self] in
                    self?.jobsCollectionView.reloadData()
                    self?.toggleNoJobsView(jobInfosEmpty: self?.jobInfos.isEmpty ?? false)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("getNumberForStatus"), object: nil, userInfo: ["jobs": jobs])
                }
            }
        }
    }
    
    private func updateProfileInfo() {
        ProfileSettingsDataManager.fetchProfileSettings { profiles in
            if let profiles = profiles {
                let fetchedProfile = profiles[0]
                profileSettings = ProfileSettingsViewModel(profileSettings: fetchedProfile)
                
                DispatchQueue.main.async { [weak self] in
                    self?.greetLabel.text = self?.profileSettings?.profileNameLabelString
                    self?.titleLabel.text = self?.profileSettings?.profileTitleLabelString
                    self?.profileImage.image = self?.profileSettings?.profileImage
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = HomeView()
        view = contentView
        
        profileSectionView = contentView.profileSectionView
        profileImage = profileSectionView.profileImage
        greetLabel = profileSectionView.greetLabel
        titleLabel = profileSectionView.titleLabel
        
        setJobInfosAndStatus()
        
        updateProfileInfo()
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        addButton = contentView.addButton
        
        tilesView = contentView.bottomView
        viewAllButton = contentView.viewAllButton
        viewFavoritesButton = contentView.viewFavoritesButton
        
        noJobsView = contentView.noJobsView
        noFavsView = contentView.noFavsView
        
        addAddButtonFunction()
        addFunctionsToFilterButtons()
        enableProfileSectionTappable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(filterStatus), name: NSNotification.Name("tappedStatus"), object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addFunctionsToFilterButtons() {
        viewAllButton.addTarget(self, action: #selector(allOrFavoritesButtonPressed), for: .touchUpInside)
        viewFavoritesButton.addTarget(self, action: #selector(allOrFavoritesButtonPressed), for: .touchUpInside)
    }
    
    private func addAddButtonFunction() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    private func enableProfileSectionTappable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        profileSectionView.isUserInteractionEnabled = true
        profileSectionView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func filterStatus(notification: Notification) -> Void {
        guard let statusName = notification.userInfo!["statusName"], let  selected = notification.userInfo!["selected"] else { return }
        
        if selected as! Bool {
            checkedStatus.append(statusName as! String)
        } else {
            if let index = checkedStatus.firstIndex(of: statusName as! String) {
                checkedStatus.remove(at: index)
            }
        }
        
        filteringJobs()
    }

    @objc func allOrFavoritesButtonPressed(sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = !sender.isSelected
        }
        sender.setTitleColor(.white, for: .normal)
        
        if sender.tag == 1 {
            viewAll = true
            allOrFavoriteToggleColorWithAnimate(sender: sender, affectedBtn: viewFavoritesButton)
        } else {
            viewAll = false
            allOrFavoriteToggleColorWithAnimate(sender: sender, affectedBtn: viewAllButton)
        }
        
        filteringJobs()
    }
    
    private func allOrFavoriteToggleColorWithAnimate(sender: UIButton, affectedBtn: AllFavoritesButton) {
        UIView.animate(withDuration: 0.4) {
            let tag1 : Bool = sender.tag == 1
            sender.backgroundColor = tag1 ? Colors.blueGrey : Colors.viewOrange
            sender.tintColor = .white
            affectedBtn.tintColor = tag1 ? Colors.viewOrange : Colors.blueGrey
            affectedBtn.setTitleColor(tag1 ? Colors.viewOrange : Colors.blueGrey, for: .normal)
            affectedBtn.backgroundColor = Colors.lightOrange
        }
    }
    
    @objc func addButtonPressed(sender: UIButton, gestureRecognizer: UITapGestureRecognizer) {
        addButton.handleTapShortDuration(gestureRecognizer: gestureRecognizer)
        present(AddEditViewController(fromDetailsView: false, passedJob: nil, addJobInfoDelegate: self, updateJobInfoInDetailsVCDelegate: nil), animated: true, completion: nil)
    }
    
    @objc func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        profileSectionView.handleTapLongDuration(gestureRecognizer: tapGestureRecognizer)
        if let profile = profileSettings {
            present(ProfileSettingsViewController(profile: profile, homeVCDelegate: self), animated: true, completion: nil)
        }
        
    }
    
    private func filteringJobs() {
        if !viewAll {
            if checkedStatus.isEmpty {
                filteredJobInfos = jobInfos.filter{$0.favorite}
            } else {
                filteredJobInfos = jobInfos.filter{$0.favorite && checkedStatus.contains($0.status)}
            }
            toggleNoFavsView(favsEmpty: filteredJobInfos.isEmpty)
        } else {
            if checkedStatus.isEmpty {
                filteredJobInfos = jobInfos
            } else {
                filteredJobInfos = jobInfos.filter{checkedStatus.contains($0.status)}
            }
            
            toggleNoJobsView(jobInfosEmpty: filteredJobInfos.isEmpty)
        }
        jobsCollectionView.reloadData()
    }
    
    private func toggleNoJobsView(jobInfosEmpty: Bool) {
        noFavsView.isHidden = true
        noJobsView.isHidden = !jobInfosEmpty
    }
    private func toggleNoFavsView(favsEmpty: Bool) {
        noJobsView.isHidden = true
        noFavsView.isHidden = !favsEmpty
    }
    
}

// MARK: - CollectionView Extension

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredJobInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobsCollectionViewCell.identifier, for: indexPath) as? JobsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentJob = filteredJobInfos[indexPath.row]
        cell.jobInfoViewModel = currentJob
        cell.alpha = 0
        cell.animateCollectionView(cell: cell)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(JobDetailsViewController(selectedJob: filteredJobInfos[indexPath.row], addJobInfoDelegate: self), animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.collectionViewCellTapped()
    }
}


// MARK: - HomeViewControllerDelegate extenstion
extension HomeViewController: HomeVCDelegate {
    
    func updateJonInfoFavorite(jobInfo: JobInfoViewModel) {
        self.filteringJobs()
    }

    
    func fetchJobInfosAndReload() {
        self.setJobInfosAndStatus()
    }
    
    func updateProfileSettings() {
        self.updateProfileInfo()
    }
}
