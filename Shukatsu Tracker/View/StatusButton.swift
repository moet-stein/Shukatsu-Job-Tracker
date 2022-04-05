//
//  StatusBoxView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class StatusButton: UIButton {
    
    var status: String
    var textColor: String
    var number: Int
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Bold", size: 15)
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Regular", size: 22)
        return label
    }()
    
    init(status: String, textColor: String, number: Int, frame: CGRect = .zero) {
        self.status = status
        self.textColor = textColor
        self.number = number
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel.text = status
        statusLabel.textColor = UIColor(named: textColor)
        numberLabel.text = String(number)
        numberLabel.textColor = UIColor(named: textColor)
        
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "lightOrange")
        isSelected = false
        widthAnchor.constraint(equalToConstant: 70).isActive = true
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(statusLabel)
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 80),
            
            numberLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 3),
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func  buttonPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            statusLabel.textColor = .white
            numberLabel.textColor = .white
            backgroundColor = UIColor(named: textColor)
            print(sender.isSelected)
        } else {
            statusLabel.textColor = UIColor(named: textColor)
            numberLabel.textColor = UIColor(named: textColor)
            backgroundColor = UIColor(named: "lightOrange")
            print(sender.isSelected)
        }
    }
    
}
