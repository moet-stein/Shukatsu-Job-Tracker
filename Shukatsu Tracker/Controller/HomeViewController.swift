//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeViewController: UIViewController {
    let jobs: Jobs
    var filteredJobs = [Job]()
    var checkedStatus = [String]()
    var viewAll = true
    
    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    private var openBoxButton: StatusButton!
    private var appliedBoxButton: StatusButton!
    private var interviewBoxButton: StatusButton!
    private var closedBoxButton: StatusButton!
    
    private var viewAllButton: AllFavoritesButton!
    private var viewFavoritesButton: AllFavoritesButton!
    
    
    init(jobs: Jobs) {
        self.jobs = jobs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = HomeView()
        view = contentView
        filteredJobs = jobs.jobs
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        openBoxButton = contentView.openBoxButton
        appliedBoxButton = contentView.appliedBoxButton
        interviewBoxButton = contentView.interviewBoxButton
        closedBoxButton = contentView.closedBoxButton
        
        viewAllButton = contentView.viewAllButton
        viewFavoritesButton = contentView.viewFavoritesButton
        
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
    
    @objc func statusButtonPressed(sender: UIButton) {
        
        let tappedCurrentTitle = sender.currentTitle ?? ""
        
        if sender.isSelected {
            checkedStatus.append(tappedCurrentTitle)
        } else {
            if let index = checkedStatus.firstIndex(of: tappedCurrentTitle) {
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
            
            sender.backgroundColor = UIColor(named: "blueGrey")
            viewFavoritesButton.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
            viewFavoritesButton.backgroundColor = UIColor(named: "lightOrange")
            
        } else {
            viewAll = false
            
            sender.backgroundColor = UIColor(named: "viewOrange")
            viewAllButton.setTitleColor(UIColor(named: "blueGrey"), for: .normal)
            viewAllButton.backgroundColor = UIColor(named: "lightOrange")
        }
        
        filteringJobs()
    }
    
    private func filteringJobs() {
        if !viewAll {
            if checkedStatus.isEmpty {
                filteredJobs = jobs.jobs.filter{$0.favorite}
            } else {
                filteredJobs = jobs.jobs.filter{$0.favorite && checkedStatus.contains($0.status)}
            }
        } else {
            if checkedStatus.isEmpty {
                filteredJobs = jobs.jobs
            } else {
                filteredJobs = jobs.jobs.filter{checkedStatus.contains($0.status)}
            }
        }
        jobsCollectionView.reloadData()
    }
    
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredJobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobsCollectionViewCell.identifier, for: indexPath) as? JobsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentJob = filteredJobs[indexPath.row]
        cell.setupCellContent(companyName: currentJob.companyName, location: currentJob.location ?? "none", updatedDate: currentJob.lastUpdate, status: currentJob.status)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(filteredJobs[indexPath.row].companyName)")
    }
}

