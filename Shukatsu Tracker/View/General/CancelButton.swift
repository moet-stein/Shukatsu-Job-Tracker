//
//  CancelButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.05.22.
//

import UIKit

class CancelButton: UIButton {
    
    
    var buttonColor: UIColor
    
    init(buttonColor: UIColor, frame: CGRect = .zero) {
        self.buttonColor = buttonColor
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .large)
        let symbolImage = UIImage(systemName: "xmark.circle", withConfiguration: largeConfig)
        
        setImage(symbolImage, for: .normal)
        tintColor = buttonColor
    }
    
}
