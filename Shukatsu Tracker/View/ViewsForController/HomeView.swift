//
//  HomeView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeView: UIView {
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = Colors.bgOffwhite
        return scrollView
    }()
    
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
    
    let profileImage: ProfileImageView = {
        let uiImageView = ProfileImageView(size: 60)
        return uiImageView
    }()
    
    let greetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Good morning, Moe"
        label.font = UIFont(name: Fonts.latoBold, size: 20)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Future iOS Engineer"
        label.font = UIFont(name: Fonts.latoRegular, size: 15)
        return label
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
    
    private let tilesView: UIView = {
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
        layout.itemSize = CGSize(width: frame.size.width / 2.7, height: 150)
        
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
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setUpUI()
        setTilesViewSection()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        scrollView.addSubview(greetLabel)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(addButton)
        scrollView.addSubview(statusStackView)
        scrollView.addSubview(tilesView)

        statusStackView.addArrangedSubview(openBoxButton)
        statusStackView.addArrangedSubview(appliedBoxButton)
        statusStackView.addArrangedSubview(interviewBoxButton)
        statusStackView.addArrangedSubview(closedBoxButton)
        
        NSLayoutConstraint.activate([
            greetLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            greetLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            greetLabel.widthAnchor.constraint(equalToConstant: 200),
            greetLabel.heightAnchor.constraint(equalToConstant: 25),
            
            profileImage.topAnchor.constraint(equalTo: greetLabel.topAnchor),
            profileImage.trailingAnchor.constraint(equalTo: greetLabel.leadingAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: greetLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            addButton.leadingAnchor.constraint(equalTo: greetLabel.trailingAnchor, constant: 30),
            
            statusStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            statusStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statusStackView.widthAnchor.constraint(equalToConstant: 340),
            statusStackView.heightAnchor.constraint(equalToConstant: 70),
            
            tilesView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 25),
            tilesView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tilesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tilesView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tilesView.heightAnchor.constraint(equalToConstant: 580),
            tilesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
        ])
        
        
        
    }
    
    private func setTilesViewSection() {
        tilesView.addSubview(viewAllButton)
        tilesView.addSubview(viewFavoritesButton)
        tilesView.addSubview(jobsCollectionView)
        tilesView.addSubview(noJobsView)
        tilesView.addSubview(noFavsView)
        
        NSLayoutConstraint.activate([

            viewAllButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewAllButton.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 130),
            viewAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewFavoritesButton.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewFavoritesButton.widthAnchor.constraint(equalToConstant: 130),
            viewFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            noJobsView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 50),
            noJobsView.centerXAnchor.constraint(equalTo: tilesView.centerXAnchor),
            
            noFavsView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 50),
            noFavsView.centerXAnchor.constraint(equalTo: tilesView.centerXAnchor),
            
            jobsCollectionView.centerXAnchor.constraint(equalTo: tilesView.centerXAnchor),
            jobsCollectionView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: tilesView.leadingAnchor, constant: 20),
            jobsCollectionView.trailingAnchor.constraint(equalTo: tilesView.trailingAnchor, constant: -20),
            jobsCollectionView.heightAnchor.constraint(equalToConstant: 500),
//            jobsCollectionView.bottomAnchor.constraint(equalTo: tilesView.bottomAnchor)
        ])
    }
    
}
