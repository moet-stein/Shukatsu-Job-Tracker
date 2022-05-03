//
//  ProfileImageView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 03.05.22.
//

import UIKit

class ProfileImageView: UIImageView {

    private var size: CGFloat

    init(size: CGFloat) {
        self.size = size
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
        
        
        let radius = CGFloat(size / 2)
        layer.cornerRadius = radius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
