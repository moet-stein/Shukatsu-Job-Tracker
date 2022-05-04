//
//  ProfileSettingsView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class ProfileSettingsView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = Colors.lightOrange
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile Settings"
        label.font = UIFont(name: Fonts.latoRegular, size: 30)
        label.textColor = Colors.skyBlue
        return label
    }()
    
    let profileImageView: ProfileImageView = {
        let uiImageView = ProfileImageView(size: 120)
        return uiImageView
    }()
    
    let editProfileCameraButton: CircleButton = {
        let button = CircleButton(buttonSize: 40, bgColor: UIColor.gray, buttonText: nil, sfSymbolName: "camera.circle")
        return button
    }()
    
    
    let setttingsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        return tableView
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(editProfileCameraButton)
        scrollView.addSubview(setttingsTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),

            profileImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 60),
            profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            editProfileCameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            editProfileCameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            setttingsTableView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            setttingsTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            setttingsTableView.widthAnchor.constraint(equalToConstant: 370),
            setttingsTableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    

}
