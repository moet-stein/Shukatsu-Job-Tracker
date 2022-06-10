//
//  FilterButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class AllFavFilterButton: UIButton {

    var buttonText: String
    var color: UIColor
    var leftCorner: Bool
    var sfSymbol: String
    
    init(buttonText: String, color: UIColor, leftCorner: Bool, sfSymbol: String, frame: CGRect = .zero) {
        self.buttonText = buttonText
        self.color = color
        self.leftCorner = leftCorner
        self.sfSymbol = sfSymbol
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {

        if leftCorner {
            setTitleColor(.white, for: .normal)
            backgroundColor = color
            tintColor = .white
        } else {
            setTitleColor(color, for: .normal)
            backgroundColor = UIColor(named: "lightOrange")
            tintColor = color
        }
        
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .small)

        let sfSymbolImage = UIImage(systemName: sfSymbol, withConfiguration: config)

        setImage(sfSymbolImage, for: .normal)
        
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(buttonText, for: .normal)
        titleLabel?.font = UIFont(name: Fonts.latoBold, size: 15)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = leftCorner ? [.layerMinXMaxYCorner, .layerMinXMinYCorner] : [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
