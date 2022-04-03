//
//  GoButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 03.04.22.
//

import UIKit

class GoButton: UIButton {
    var buttonSize: CGFloat
    
    init(buttonSize: CGFloat, frame: CGRect = .zero) {
        self.buttonSize = buttonSize
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("GO", for: .normal)
        titleLabel?.font = UIFont(name: "Lato-Regular", size: 20)
        backgroundColor = UIColor(red: 0.64, green: 0.82, blue: 1.00, alpha: 1.00)

        widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        layer.cornerRadius = buttonSize / 2
    }
}
