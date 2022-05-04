//
//  GoButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 03.04.22.
//

import UIKit

class CircleButton: UIButton {
    var buttonSize: CGFloat
    var bgColor: UIColor
    var buttonText: String?
    var sfSymbolName: String?
    
    init(buttonSize: CGFloat, bgColor: UIColor, buttonText: String?, sfSymbolName: String?, frame: CGRect = .zero) {
        self.buttonSize = buttonSize
        self.bgColor = bgColor
        self.buttonText = buttonText
        self.sfSymbolName = sfSymbolName
        
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let text = buttonText {
            setTitle(text, for: .normal)
        }
        
        if let sfSymbol = sfSymbolName {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
            let symbolImage = UIImage(systemName: sfSymbol, withConfiguration: largeConfig)
            
            setImage(symbolImage, for: .normal)
            tintColor = .white
        }
        
        titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 20)
        backgroundColor = bgColor

        widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        layer.cornerRadius = buttonSize / 2
    }
}
