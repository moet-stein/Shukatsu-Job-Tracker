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
    
    
    private let openBoxView: StatusBoxView = {
       let view = StatusBoxView(status: "open", textColor: "skyBlue", number: 15)
       return view
    }()
    
    private let appliedBoxView: StatusBoxView = {
        let view = StatusBoxView(status: "applied", textColor: "lightGreen", number: 15)
        return view
    }()
    
    private let interviewBoxView: StatusBoxView = {
        let view = StatusBoxView(status: "interview", textColor: "viewOrange", number: 3)
        return view
    }()
    
    private let closedBoxView: StatusBoxView = {
        let view = StatusBoxView(status: "closed", textColor: "blueGrey", number: 6)
        return view
    }()
    
    // MARK: - companyTiles section
    
    private let tilesView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightOrange")
        view.layer.cornerRadius = 30
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "bgOffwhite")
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        addSubview(addButton)
        addSubview(tilesView)
        setProfileSection()
        setStatusSection()
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            tilesView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 20),
            tilesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tilesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tilesView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    
}
