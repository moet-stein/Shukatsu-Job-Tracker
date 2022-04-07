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
        scrollView.backgroundColor = UIColor(named: "bgOffwhite")
        return scrollView
    }()
    
    private let addButton: circleButton = {
        let button = circleButton(
            buttonSize: 50,
            bgColor: UIColor(named: "viewOrange") ?? .black,
            buttonText: nil,
            sfSymbolName: "plus"
        )
        return button
    }()
    
    // MARK: - Proifile Section
    
    private let profileImage: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        uiImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let image = UIImage(named: "azuImage")
        uiImageView.contentMode = UIView.ContentMode.scaleAspectFill
        uiImageView.image = image
        
        let radius = CGFloat(60 / 2)
        uiImageView.layer.cornerRadius = radius
        uiImageView.clipsToBounds = true
        
        return uiImageView
    }()
    
    private let greetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Good morning, Moe"
        label.font = UIFont(name: "Lato-Bold", size: 20)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Future iOS Engineer"
        label.font = UIFont(name: "Lato-Regular", size: 15)
        return label
    }()
    
    // MARK: - Status Section
    let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private let openBoxView: StatusButton = {
        let button = StatusButton(status: "open", textColor: "skyBlue", number: 15)
        return button
    }()
    
    private let appliedBoxView: StatusButton = {
        let button = StatusButton(status: "applied", textColor: "lightGreen", number: 15)
        return button
    }()
    
    private let interviewBoxView: StatusButton = {
        let button = StatusButton(status: "interview", textColor: "viewOrange", number: 3)
        return button
    }()
    
    private let closedBoxView: StatusButton = {
        let button = StatusButton(status: "closed", textColor: "blueGrey", number: 6)
        return button
    }()
    
    // MARK: - companyTiles section
    
    private let tilesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightOrange")
        view.layer.cornerRadius = 30
        return view
    }()
    
    // MARK: - viewAll favoites toggle
    
    lazy var viewAllButton: FilterButton = {
        let button = FilterButton(buttonText: "View All", colorName: "blueGrey", leftCorner: true)
        button.isSelected = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    
    lazy var viewFavoritesButton: FilterButton = {
        let button = FilterButton(buttonText: "View Favorites", colorName: "viewOrange", leftCorner: false)
        button.isSelected = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    // MARK: - Collection View
    lazy var jobsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 200)
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = UIColor(named: "blueGrey")
//        collectionView.register(WordsCollectionViewCell.self, forCellWithReuseIdentifier: WordsCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
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
    
    @objc func  buttonPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.setTitleColor(.white, for: .normal)
        if sender.tag == 1 {
            sender.backgroundColor = UIColor(named: "blueGrey")
            viewFavoritesButton.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
            viewFavoritesButton.backgroundColor = UIColor(named: "lightOrange")
        } else {
            sender.backgroundColor = UIColor(named: "viewOrange")
            viewAllButton.setTitleColor(UIColor(named: "blueGrey"), for: .normal)
            viewAllButton.backgroundColor = UIColor(named: "lightOrange")
        }
    }
    
    
    private func setUpUI() {
        scrollView.addSubview(greetLabel)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(addButton)
        scrollView.addSubview(statusStackView)
        scrollView.addSubview(tilesView)

        statusStackView.addArrangedSubview(openBoxView)
        statusStackView.addArrangedSubview(appliedBoxView)
        statusStackView.addArrangedSubview(interviewBoxView)
        statusStackView.addArrangedSubview(closedBoxView)
        
        NSLayoutConstraint.activate([
            greetLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            greetLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            greetLabel.widthAnchor.constraint(equalToConstant: 200),
            greetLabel.heightAnchor.constraint(equalToConstant: 25),
            
            profileImage.topAnchor.constraint(equalTo: greetLabel.topAnchor),
            profileImage.trailingAnchor.constraint(equalTo: greetLabel.leadingAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: greetLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            addButton.leadingAnchor.constraint(equalTo: greetLabel.trailingAnchor, constant: 40),
            
            statusStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            statusStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statusStackView.widthAnchor.constraint(equalToConstant: 320),
            statusStackView.heightAnchor.constraint(equalToConstant: 70),
            
            tilesView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 15),
            tilesView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tilesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tilesView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tilesView.heightAnchor.constraint(equalToConstant: 550),
            tilesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
        ])
        
        
        
    }
    
    private func setTilesViewSection() {
        tilesView.addSubview(viewAllButton)
        tilesView.addSubview(viewFavoritesButton)
        tilesView.addSubview(jobsCollectionView)
        
        NSLayoutConstraint.activate([

            viewAllButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewAllButton.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 130),
            viewAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewFavoritesButton.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewFavoritesButton.widthAnchor.constraint(equalToConstant: 130),
            viewFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            jobsCollectionView.centerXAnchor.constraint(equalTo: tilesView.centerXAnchor),
            jobsCollectionView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 10),
            jobsCollectionView.leadingAnchor.constraint(equalTo: tilesView.leadingAnchor),
            jobsCollectionView.trailingAnchor.constraint(equalTo: tilesView.trailingAnchor),
            jobsCollectionView.heightAnchor.constraint(equalToConstant: 400),
            jobsCollectionView.bottomAnchor.constraint(equalTo: tilesView.bottomAnchor)
        ])
    }
    
}
