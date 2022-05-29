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
        
        return view
    }()
    
    // MARK: - Status Section
    let statusStackView: UIStackView = {
        let stackView = UIStackView()
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
    
    lazy var viewAllButton: AllFavoritesButton = {
        let button = AllFavoritesButton(buttonText: "All", color: Colors.blueGrey, leftCorner: true, sfSymbol: "square.grid.2x2")
        button.isSelected = true
        button.tag = 1
        return button
    }()
    
    
    lazy var viewFavoritesButton: AllFavoritesButton = {
        let button = AllFavoritesButton(buttonText: "Favorites", color: Colors.viewOrange, leftCorner: false, sfSymbol: "heart")
        button.isSelected = false
        button.tag = 2
        return button
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

        statusStackView.addArrangedSubview(openBoxButton)
        statusStackView.addArrangedSubview(appliedBoxButton)
        statusStackView.addArrangedSubview(interviewBoxButton)
        statusStackView.addArrangedSubview(closedBoxButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            profileSectionView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            profileSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileSectionView.widthAnchor.constraint(equalToConstant: 220),
            profileSectionView.heightAnchor.constraint(equalToConstant: 60),
            
            statusStackView.topAnchor.constraint(equalTo: profileSectionView.bottomAnchor, constant: 30),
            statusStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusStackView.widthAnchor.constraint(equalToConstant: 340),
            
            bottomView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 45),
            bottomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
        
        
        
    }
    
    private func setTilesViewSection() {
        bottomView.addSubview(viewAllButton)
        bottomView.addSubview(viewFavoritesButton)
        bottomView.addSubview(jobsCollectionView)
        bottomView.addSubview(noJobsView)
        bottomView.addSubview(noFavsView)
        
        NSLayoutConstraint.activate([

            viewAllButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            viewAllButton.trailingAnchor.constraint(equalTo: centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 130),
            viewAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            viewFavoritesButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            viewFavoritesButton.widthAnchor.constraint(equalToConstant: 130),
            viewFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            noJobsView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 50),
            noJobsView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            noFavsView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 50),
            noFavsView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            jobsCollectionView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            jobsCollectionView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            jobsCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            jobsCollectionView.heightAnchor.constraint(equalTo: bottomView.heightAnchor),
        ])
    }
    
}
