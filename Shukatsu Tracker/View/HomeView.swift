//
//  HomeView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeView: UIView {
    
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
        stackView.distribution = .fillProportionally
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
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "bgOffwhite")
        setUpUI()
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
        addSubview(addButton)
        addSubview(tilesView)
        setProfileSection()
        setStatusSection()
        setTilesViewSection()
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            tilesView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 20),
            tilesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tilesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tilesView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    private func setProfileSection() {
        addSubview(profileImage)
        addSubview(greetLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            greetLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            greetLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: greetLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
        ])
    }
    
    private func setStatusSection() {
        addSubview(statusStackView)
        
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            statusStackView.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
        ])
        
        statusStackView.addArrangedSubview(openBoxView)
        statusStackView.addArrangedSubview(appliedBoxView)
        statusStackView.addArrangedSubview(interviewBoxView)
        statusStackView.addArrangedSubview(closedBoxView)
        
    }
    
    private func setTilesViewSection() {
        tilesView.addSubview(viewAllButton)
        tilesView.addSubview(viewFavoritesButton)
        
        NSLayoutConstraint.activate([
            viewAllButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewAllButton.trailingAnchor.constraint(equalTo: centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 130),
            viewAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: tilesView.topAnchor, constant: 20),
            viewFavoritesButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            viewFavoritesButton.widthAnchor.constraint(equalToConstant: 130),
            viewFavoritesButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
