//
//  EditStatusButton.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.04.22.
//

import UIKit

class EditStatusButton: UIButton {
    
    var status: JobStatus
    
    var bgColor: UIColor {
        switch status {
        case .open:
            return Colors.skyBlue
        case .applied:
            return Colors.lightGreen
        case .interview:
            return Colors.viewOrange
        case .closed:
            return Colors.blueGrey
        }
    }
    
    init(status: JobStatus, frame: CGRect = .zero) {
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
