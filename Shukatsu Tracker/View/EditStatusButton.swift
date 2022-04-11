//
//  EditStatusButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.04.22.
//

import UIKit

class EditStatusButton: UIButton {
    
    var status: String
    
    var bgColor: UIColor {
        switch status {
        case "open":
            return UIColor(named: "skyBlue")!
        case "applied":
            return UIColor(named: "lightGreen")!
        case "interview":
            return UIColor(named: "viewOrange")!
        case "closed":
            return UIColor(named: "blueGrey")!
        default:
            return UIColor.brown
        }
    }
    
    init(status: String, frame: CGRect = .zero) {
        self.status = status
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = bgColor
    }

    func addRemoveCheckSymbol() {
        if isSelected {
            let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .small)
            let checkmark = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
            tintColor = .white
            setImage(checkmark, for: .normal)
        } else {
            tintColor = .clear
        }
    }
}
