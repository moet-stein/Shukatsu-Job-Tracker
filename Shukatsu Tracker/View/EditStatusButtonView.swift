//
//  EditStatusButto.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.04.22.
//

import UIKit

class EditStatusButtonView: UIView {
    
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
    var selected: Bool
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let statusButton: EditStatusButton = {
        let button = EditStatusButton()
        return button
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Regular", size: 13)
        return label
    }()
    
    init(status: String, selected: Bool, frame: CGRect = .zero) {
        self.status = status
        self.selected = selected
        super.init(frame: frame)
        self.setUpUI()
        self.setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(vStackView)
        vStackView.addArrangedSubview(statusButton)
        vStackView.addArrangedSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStackView.widthAnchor.constraint(equalToConstant: 55),
            vStackView.heightAnchor.constraint(equalToConstant: 70),
            
            statusButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setContent() {
        statusLabel.text = status
        statusButton.addBgColor(bgColor: bgColor)
    }
}
