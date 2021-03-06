//
//  NotFoundWithImageView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 03.05.22.
//

import UIKit

class NotFoundWithImageView: UIView {

    private var title: String
    private var imageName: String
    private var textColor: UIColor
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoBold, size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let noInternetImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiImageView
    }()

    init(title: String, imageName: String, textColor: UIColor) {
        self.title = title
        self.imageName = imageName
        self.textColor = textColor
        super.init(frame: .zero)
        
        setUpUI()
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        
        addSubview(titleLabel)
        addSubview(noInternetImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            noInternetImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            noInternetImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noInternetImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            noInternetImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setUpContent() {
        titleLabel.text = title
        titleLabel.textColor = textColor
        
        let image = UIImage(named: imageName)
        noInternetImageView.contentMode = UIView.ContentMode.scaleAspectFill
        noInternetImageView.image = image
    }

}
