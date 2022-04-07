//
//  HomeViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeViewController: UIViewController {
    private var jobs = Jobs().jobs

    private var contentView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        contentView = HomeView()
        view = contentView
        
        jobsCollectionView = contentView.jobsCollectionView
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobsCollectionViewCell.identifier, for: indexPath) as? JobsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentJob = jobs[indexPath.row]
        cell.setupCellContent(companyName: currentJob.companyName, location: currentJob.location ?? "none", updatedDate: currentJob.lastUpdate, status: currentJob.status)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(jobs[indexPath.row].companyName)")
    }
}
