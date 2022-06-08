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
    
    var profileSettings: ProfileSettings?
    
    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    private var addButton: CircleButton!
    
    private var profileSectionView: ProfileSectionView!

    private var profileImage: ProfileImageView!
    private var greetLabel: UILabel!
    private var titleLabel: UILabel!
    
    private var openBoxButton: StatusButton!
    private var appliedBoxButton: StatusButton!
    private var interviewBoxButton: StatusButton!
    private var closedBoxButton: StatusButton!
    
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
                    self?.updateStatusBoxes()
                }
            }
        }
    }
    
    private func updateProfileInfo() {
        ProfileSettingsDataManager.fetchProfileSettings { profiles in
            if let profiles = profiles {
                let fetchedProfile = profiles[0]
                profileSettings = fetchedProfile
                
                var name = fetchedProfile.profileName ?? "unknown"
                if name.isEmpty{ name = "unknown"}
                
                var title = fetchedProfile.profileTitle ?? "unknown title"
                if title.isEmpty { title = "unknown title"}
                
                var uiImage = UIImage(named: "azuImage")!
                
                if let image = fetchedProfile.profileImage {
                    uiImage = UIImage(data: image)!
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.greetLabel.text = "Hello, \(name)"
                    self?.titleLabel.text = title
                    self?.profileImage.image = uiImage
                }
            }
        }
    }
    
    private func updateStatusBoxes() {
        openBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == JobStatus.open.rawValue}.count)
        appliedBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == JobStatus.applied.rawValue}.count)
        interviewBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == JobStatus.interview.rawValue}.count)
        closedBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == JobStatus.closed.rawValue}.count)
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
        
        openBoxButton = contentView.openBoxButton
        appliedBoxButton = contentView.appliedBoxButton
        interviewBoxButton = contentView.interviewBoxButton
        closedBoxButton = contentView.closedBoxButton
        
        tilesView = contentView.bottomView
        viewAllButton = contentView.viewAllButton
        viewFavoritesButton = contentView.viewFavoritesButton
        
        noJobsView = contentView.noJobsView
        noFavsView = contentView.noFavsView
        
        addAddButtonFunction()
        addFunctionToStatusButtons()
        addFunctionsToFilterButtons()
        enableProfileSectionTappable()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addFunctionToStatusButtons() {
        openBoxButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        appliedBoxButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        interviewBoxButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        closedBoxButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
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
    
    
    @objc func statusButtonPressed(sender: UIButton) {
        let button = sender as! StatusButton
        
        sender.isSelected = !sender.isSelected
        
        let tappedCurrentTitle = sender.currentTitle ?? ""
        
        if sender.isSelected {
            checkedStatus.append(tappedCurrentTitle)
            
            let textColor = button.statusLabel.textColor
            
            UIView.animate(withDuration: 0.5) {
                button.statusLabel.textColor = .white
                button.numberLabel.textColor = .white
                button.backgroundColor = textColor
            }
            
        } else {
            if let index = checkedStatus.firstIndex(of: tappedCurrentTitle) {
                checkedStatus.remove(at: index)
            }
            let textColor = button.backgroundColor
            
            UIView.animate(withDuration: 0.5) {
                button.statusLabel.textColor = textColor
                button.numberLabel.textColor = textColor
                button.backgroundColor = Colors.lightOrange
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
            
            UIView.animate(withDuration: 0.4) {
                sender.backgroundColor = Colors.blueGrey
                sender.tintColor = .white
                self.viewFavoritesButton.tintColor = Colors.viewOrange
                self.viewFavoritesButton.setTitleColor(Colors.viewOrange, for: .normal)
                self.viewFavoritesButton.backgroundColor = Colors.lightOrange
            }
            
        } else {
            viewAll = false
            
            UIView.animate(withDuration: 0.4) {
                sender.backgroundColor = Colors.viewOrange
                sender.tintColor = .white
                self.viewAllButton.tintColor = Colors.blueGrey
                self.viewAllButton.setTitleColor(Colors.blueGrey, for: .normal)
                self.viewAllButton.backgroundColor = Colors.lightOrange
            }
            
        }
        
        filteringJobs()
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

extension HomeViewController: HomeVCDelegate {
    
    func updateJonInfoFavorite(jobInfo: JobInfoViewModel) {
        self.filteringJobs()
    }
    
    func updateJobInfo(jobInfo: JobInfoViewModel) {
        JobInfoDataManager.fetchJobInfo(usingId: jobInfo.id) { job in
            guard let job = job else {
                return
            }
            
            if let index = self.filteredJobInfos.firstIndex(where: {$0.id == job.id}) {
                self.filteredJobInfos[index] = JobInfoViewModel(jobInfo: job)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.filteringJobs()
                self?.updateStatusBoxes()
            }
        }
        
    }
    
    func fetchJobInfosAndReload() {
        JobInfoDataManager.fetchJonInfos { [weak self] jobInfos in
            guard let jobs = jobInfos else {
                return
            }
            
            self?.jobInfos = jobs.map{JobInfoViewModel(jobInfo: $0)}
            DispatchQueue.main.async {
                self?.jobsCollectionView.reloadData()
                self?.filteringJobs()
                self?.updateStatusBoxes()
            }
        }
    }
    
    func updateProfileSettings() {
        self.updateProfileInfo()
    }
}
