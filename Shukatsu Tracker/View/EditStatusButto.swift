//
//  EditStatusButto.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.04.22.
//

import UIKit

class EditStatusButto: UIView {
    
    var status: String
    var selected: Bool
    
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
    
    private let vStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Bold", size: 15)
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
            vStackView.widthAnchor.constraint(equalToConstant: 80),
            vStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setContent() {
        statusButton.setTitle(status, for: .normal)
        statusButton.backgroundColor = bgColor
        statusLabel.text = status
    }
}
