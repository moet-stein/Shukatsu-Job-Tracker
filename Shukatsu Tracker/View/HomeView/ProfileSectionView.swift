//
//  ProfileSectionView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 13.05.22.
//

import UIKit

class ProfileSectionView: UIView {
    let profileImage: ProfileImageView = {
        let uiImageView = ProfileImageView(size: 60)
        return uiImageView
    }()
    
    let greetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoBold, size: 20)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoRegular, size: 15)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setUpUI() {
        addSubview(profileImage)
        addSubview(greetLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            greetLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            greetLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: greetLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
    }
}
