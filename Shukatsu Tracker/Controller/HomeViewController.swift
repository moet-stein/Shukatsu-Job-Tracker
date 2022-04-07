//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeViewController: UIViewController {
//    private var jobs = Jobs().jobs
    let jobs: Jobs

    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
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
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
    }
//    override func loadView() {
//        contentView = HomeView()
//        view = contentView
//
//        jobsCollectionView = contentView.jobsCollectionView
//        jobsCollectionView.dataSource = self
//        jobsCollectionView.delegate = self
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobsCollectionViewCell.identifier, for: indexPath) as? JobsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentJob = jobs.jobs[indexPath.row]
        cell.setupCellContent(companyName: currentJob.companyName, location: currentJob.location ?? "none", updatedDate: currentJob.lastUpdate, status: currentJob.status)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(jobs.jobs[indexPath.row].companyName)")
    }
}
