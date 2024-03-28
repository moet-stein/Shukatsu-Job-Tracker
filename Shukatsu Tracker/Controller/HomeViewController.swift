//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    private lazy var coreDataStack = CoreDataStack()
    private lazy var jobInfoDataManager = JobInfoDataManager(managedObjectContext: coreDataStack.mainContext,
                                                coreDataStack: coreDataStack)
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
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = HomeView()
        view = contentView
        
        profileSectionView = contentView.profileSectionView
        profileImage = profileSectionView.profileImage
        
        setJobInfosAndStatus()
        
        updateProfileInfo()
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        addButton = contentView.addButton
        
        addAddButtonFunction()
        enableProfileSectionTappable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(filterStatus), name: NSNotification.Name("tappedStatus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(allOrFavFilter), name: NSNotification.Name("tappedAllOrFav"), object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func setJobInfosAndStatus() {
        jobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs {
                let createdJobInfoVMs = jobs.map{JobInfoViewModel(jobInfo: $0)}
                jobInfos = createdJobInfoVMs
                filteredJobInfos = jobInfos
                
                if viewAll {
                    DispatchQueue.main.async { [weak self] in
                        self?.contentView.toggleNoJobsView(jobInfosEmpty: self?.jobInfos.isEmpty ?? false)
                        self?.jobsCollectionView.reloadData()
                        NotificationCenter.default.post(name: NSNotification.Name("getNumberForStatus"), object: nil, userInfo: ["jobs": jobs])
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.contentView.toggleNoFavsView(favsEmpty: self?.jobInfos.filter{$0.favorite}.isEmpty ?? false)
                        self?.filteringJobs()
                        self?.jobsCollectionView.reloadData()
                    }
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
                    self?.profileSectionView.setUpContent(profileSettings: self?.profileSettings)
                }
            }
        }
    }
    
    private func addAddButtonFunction() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    private func enableProfileSectionTappable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
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
    
    @objc func allOrFavFilter(notification: Notification) -> Void {
        guard let viewAllBool = notification.userInfo!["viewAll"] else { return }
        
        viewAll = viewAllBool as! Bool
        filteringJobs()
    }
    
    @objc func addButtonPressed(sender: UIButton, gestureRecognizer: UITapGestureRecognizer) {
        addButton.handleTapShortDuration(gestureRecognizer: gestureRecognizer)
        showMyViewControllerInACustomizedSheet(vc: self)
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
            contentView.toggleNoFavsView(favsEmpty: filteredJobInfos.isEmpty)
        } else {
            if checkedStatus.isEmpty {
                filteredJobInfos = jobInfos
            } else {
                filteredJobInfos = jobInfos.filter{checkedStatus.contains($0.status)}
            }
            
            contentView.toggleNoJobsView(jobInfosEmpty: filteredJobInfos.isEmpty)
        }
        jobsCollectionView.reloadData()
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


func showMyViewControllerInACustomizedSheet(vc: UIViewController) {
    let viewControllerToPresent = AddEditViewController(fromDetailsView: false, passedJob: nil, addJobInfoDelegate: nil, updateJobInfoInDetailsVCDelegate: nil)
    if let sheet = viewControllerToPresent.sheetPresentationController {
        sheet.detents = [.large()]
        sheet.largestUndimmedDetentIdentifier = .medium
        sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        sheet.prefersEdgeAttachedInCompactHeight = true
        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    }
    vc.present(viewControllerToPresent, animated: true, completion: nil)
}
