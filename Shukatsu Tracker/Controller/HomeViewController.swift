//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var jobInfos = [JobInfo]()
    var filteredJobInfos = [JobInfo]()
    var checkedStatus = [String]()
    var viewAll = true
    
    var profileSettings = ProfileSettings()

    
    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    private var addButton: CircleButton!
    
    private var profileImage: UIImageView!
    private var greetLabel: UILabel!
    private var titleLabel: UILabel!
    
    private var openBoxButton: StatusButton!
    private var appliedBoxButton: StatusButton!
    private var interviewBoxButton: StatusButton!
    private var closedBoxButton: StatusButton!
    
    private var viewAllButton: AllFavoritesButton!
    private var viewFavoritesButton: AllFavoritesButton!
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        greetLabel = contentView.greetLabel
        titleLabel = contentView.titleLabel
        
        JobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs {
                jobInfos = jobs
                filteredJobInfos = jobInfos
                
                DispatchQueue.main.async { [weak self] in
                    self?.jobsCollectionView.reloadData()
                    self?.updateStatusBoxes()
                }
            }
        }
        
        ProfileSettingsDataManager.fetchProfileSettings { profiles in
            if let profiles = profiles {
                profileSettings = profiles[0]
                
                let name = profiles[0].profileName ?? ""
                let title = profiles[0].profileTitle ?? ""
                
                DispatchQueue.main.async { [weak self] in
                    self?.greetLabel.text = "Hello, \(name)"
                    self?.titleLabel.text = title
                }
            }
        }

    }
    
    private func updateStatusBoxes() {
        openBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == "open"}.count)
        appliedBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == "applied"}.count)
        interviewBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == "interview"}.count)
        closedBoxButton.numberLabel.text = String(self.jobInfos.filter{$0.status == "closed"}.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = HomeView()
        view = contentView
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        
        addButton = contentView.addButton
        
        profileImage = contentView.profileImage
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        openBoxButton = contentView.openBoxButton
        appliedBoxButton = contentView.appliedBoxButton
        interviewBoxButton = contentView.interviewBoxButton
        closedBoxButton = contentView.closedBoxButton
        
        viewAllButton = contentView.viewAllButton
        viewFavoritesButton = contentView.viewFavoritesButton
        
        addAddButtonFunction()
        addFunctionToStatusButtons()
        addFunctionsToFilterButtons()
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
    
    
    @objc func statusButtonPressed(sender: UIButton) {
        let button = sender as! StatusButton
        
        sender.isSelected = !sender.isSelected
        
        let tappedCurrentTitle = sender.currentTitle ?? ""
        
        if sender.isSelected {
            checkedStatus.append(tappedCurrentTitle)
            
            let textColor = button.statusLabel.textColor
            button.statusLabel.textColor = .white
            button.numberLabel.textColor = .white
            button.backgroundColor = textColor
        } else {
            if let index = checkedStatus.firstIndex(of: tappedCurrentTitle) {
                checkedStatus.remove(at: index)
            }
            let textColor = button.backgroundColor
            button.statusLabel.textColor = textColor
            button.numberLabel.textColor = textColor
            button.backgroundColor = UIColor(named: "lightOrange")
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
            sender.backgroundColor = UIColor(named: "blueGrey")
            sender.tintColor = .white
            viewFavoritesButton.tintColor = UIColor(named: "viewOrange")
            viewFavoritesButton.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
            viewFavoritesButton.backgroundColor = UIColor(named: "lightOrange")
            
        } else {
            viewAll = false
            sender.backgroundColor = UIColor(named: "viewOrange")
            sender.tintColor = .white
            viewAllButton.tintColor = UIColor(named: "blueGrey")
            viewAllButton.setTitleColor(UIColor(named: "blueGrey"), for: .normal)
            viewAllButton.backgroundColor = UIColor(named: "lightOrange")
        }
        
        filteringJobs()
    }
    
    @objc func addButtonPressed(sender: UIButton) {
        present(AddEditViewController(fromDetailsView: false, passedJob: nil, addJobInfoDelegate: self, updateJobInfoInDetailsVCDelegate: nil), animated: true, completion: nil)
    }
    
    @objc func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        present(ProfileSettingsViewController(), animated: true, completion: nil)
    }
    
    private func filteringJobs() {
        if !viewAll {
            if checkedStatus.isEmpty {
                filteredJobInfos = jobInfos.filter{$0.favorite}
            } else {
                filteredJobInfos = jobInfos.filter{$0.favorite && checkedStatus.contains($0.status!)}
            }
        } else {
            if checkedStatus.isEmpty {
                filteredJobInfos = jobInfos
            } else {
                filteredJobInfos = jobInfos.filter{checkedStatus.contains($0.status!)}
            }
        }
        jobsCollectionView.reloadData()
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
        
        cell.setupCellContent(
            companyName: currentJob.companyName,
            location: currentJob.location,
            updatedDate: currentJob.lastUpdate,
            status: currentJob.status ?? "open")
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(JobDetailsViewController(selectedJob: filteredJobInfos[indexPath.row], addJobInfoDelegate: self), animated: true, completion: nil)
    }
}

extension HomeViewController: EditJobInHomeVC {
    func updateJonInfoFavorite(jobInfo: JobInfo) {
        self.filteringJobs()
    }
    
    func updateJobInfo(jobInfo: JobInfo) {
        JobInfoDataManager.fetchJobInfo(usingId: jobInfo.id) { job in
            guard let job = job else {
                return
            }

            if let index = self.filteredJobInfos.firstIndex(where: {$0.id == job.id}) {
                self.filteredJobInfos[index] = job
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
            
            self?.jobInfos = jobs
            DispatchQueue.main.async {
                self?.jobsCollectionView.reloadData()
                self?.filteringJobs()
                self?.updateStatusBoxes()
            }
        }
    }
}
