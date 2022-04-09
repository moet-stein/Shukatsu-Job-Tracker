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
    
    var jobs = Jobs().jobs
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Lato-Bold", size: 15)
        return label
    }()
    
    let numberLabel: UILabel = {
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
        setTitle(status, for: .normal)
        setTitleColor(.clear, for: .normal)
        
        statusLabel.text = status
        statusLabel.textColor = UIColor(named: textColor)
        numberLabel.textColor = UIColor(named: textColor)
        
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "lightOrange")
        isSelected = false
        
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
