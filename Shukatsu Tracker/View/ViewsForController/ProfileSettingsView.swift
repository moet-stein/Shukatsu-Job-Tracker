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
        scrollView.backgroundColor = UIColor(named: "bgOffwhite")
        return scrollView
    }()
    
    let profileImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        uiImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let image = UIImage(named: "azuImage")
        uiImageView.contentMode = UIView.ContentMode.scaleAspectFill
        uiImageView.image = image
        
        let radius = CGFloat(120 / 2)
        uiImageView.layer.cornerRadius = radius
        uiImageView.clipsToBounds = true
        
        return uiImageView
    }()
    
    let editProfileCameraButton: CircleButton = {
        let button = CircleButton(buttonSize: 40, bgColor: UIColor.gray, buttonText: nil, sfSymbolName: "camera.circle")
        
        return button
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
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(editProfileCameraButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            editProfileCameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            editProfileCameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
    }
    

}
