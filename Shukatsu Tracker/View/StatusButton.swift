//
//  StatusBoxView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class StatusButton: UIButton {
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: String, textColor: String, number: Int) {
        self.init(frame: .zero)
        statusLabel.text = status
        statusLabel.textColor = UIColor(named: textColor)
        numberLabel.text = String(number)
        numberLabel.textColor = UIColor(named: textColor)
    }
    
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "lightOrange")
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
    }

}
