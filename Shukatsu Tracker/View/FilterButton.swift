//
//  FilterButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class FilterButton: UIButton {

    var buttonText: String
    var colorName: String
    var leftCorner: Bool
    
    init(buttonText: String, colorName: String, leftCorner: Bool, frame: CGRect = .zero) {
        self.buttonText = buttonText
        self.colorName = colorName
        self.leftCorner = leftCorner
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(buttonText, for: .normal)
        setTitleColor(UIColor(named: colorName), for: .normal)
        titleLabel?.font = UIFont(name: "Lato-Bold", size: 15)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = leftCorner ? [.layerMinXMaxYCorner, .layerMinXMinYCorner] : [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: colorName)?.cgColor
    }
}
