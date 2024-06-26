//
//  HomeView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeView: UIView {
    
    let addButton: CircleButton = {
        let button = CircleButton(
            buttonSize: 50,
            bgColor: Colors.viewOrange,
            buttonText: nil,
            sfSymbolName: "plus"
        )
        return button
    }()
    
    // MARK: - Proifile Section
    
    let profileSectionView: ProfileSectionView = {
       let view = ProfileSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Status Section
    lazy var statusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            openBoxButton, appliedBoxButton, interviewBoxButton, closedBoxButton
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 17
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let openBoxButton: StatusButton = {
        let button = StatusButton(status: JobStatus.open)
        return button
    }()
    
    let appliedBoxButton: StatusButton = {
        let button = StatusButton(status: JobStatus.applied)
        return button
    }()
    
    let interviewBoxButton: StatusButton = {
        let button = StatusButton(status: JobStatus.interview)
        return button
    }()
    
    let closedBoxButton: StatusButton = {
        let button = StatusButton(status: JobStatus.closed)
        return button
    }()
    
    // MARK: - companyTiles section
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.lightOrange
        view.layer.cornerRadius = 30
        return view
    }()
    
    // MARK: - viewAll favoites toggle
    
    private let allFavFilterSection: UIView = {
        let view = AllFavFilterSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Collection View
    let jobsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.register(JobsCollectionViewCell.self, forCellWithReuseIdentifier: JobsCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViewLayoutSetUp()
    }
    
    private func collectionViewLayoutSetUp() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        if UIDevice.current.userInterfaceIdiom == .phone {
            layout.itemSize = CGSize(width: frame.size.width / 2.7, height: 150)
        } else {
            layout.itemSize = CGSize(width: frame.size.width / 3.5, height: 200)
        }
        
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 40, right: 15)
        jobsCollectionView.collectionViewLayout = layout
    }
    
    let noJobsView: NotFoundWithImageView = {
        let view = NotFoundWithImageView(title: "No Jobs Saved", imageName: "noJobs", textColor: Colors.skyBlue)
        view.isHidden = true
        return view
    }()
    
    let noFavsView: NotFoundWithImageView = {
        let view = NotFoundWithImageView(title: "No Favorites Saved", imageName: "noFavs", textColor: Colors.viewOrange)
        view.isHidden = true
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor =  Colors.bgOffwhite
        setUpUI()
        setTilesViewSection()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(profileSectionView)
        addSubview(addButton)
        addSubview(statusStackView)
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            
            profileSectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileSectionView.widthAnchor.constraint(equalToConstant: 220),
            profileSectionView.heightAnchor.constraint(equalToConstant: 60),
            
            addButton.topAnchor.constraint(equalTo: profileSectionView.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            statusStackView.topAnchor.constraint(equalTo: profileSectionView.bottomAnchor, constant: 30),
            statusStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statusStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            statusStackView.heightAnchor.constraint(equalToConstant: 70),
            
            
            bottomView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 45),
            bottomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
    }
    
    private func setTilesViewSection() {
        bottomView.addSubview(allFavFilterSection)
        bottomView.addSubview(jobsCollectionView)
        bottomView.addSubview(noJobsView)
        bottomView.addSubview(noFavsView)
        
        NSLayoutConstraint.activate([
            allFavFilterSection.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            allFavFilterSection.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            allFavFilterSection.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            allFavFilterSection.heightAnchor.constraint(equalToConstant: 30),
            
            noJobsView.topAnchor.constraint(equalTo: allFavFilterSection.bottomAnchor, constant: 20),
            noJobsView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            noFavsView.topAnchor.constraint(equalTo: allFavFilterSection.bottomAnchor, constant: 10),
            noFavsView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            jobsCollectionView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            jobsCollectionView.topAnchor.constraint(equalTo: allFavFilterSection.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            jobsCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            jobsCollectionView.heightAnchor.constraint(equalTo: bottomView.heightAnchor),
        ])
    }

    func toggleNoJobsView(jobInfosEmpty: Bool) {
        noFavsView.isHidden = true
        noJobsView.isHidden = !jobInfosEmpty
    }
    
    func toggleNoFavsView(favsEmpty: Bool) {
        noJobsView.isHidden = true
        noFavsView.isHidden = !favsEmpty
    }
}
