//
//  StatusBoxView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class StatusButton: UIButton {
    
    var status: JobStatus
    
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoBold, size: 15)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoRegular, size: 22)
        return label
    }()
    
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
        setTitleColor(.clear, for: .normal)
        let jobStatus = status
        
        statusLabel.text = status.rawValue
        setTitle(status.rawValue, for: .normal)
        
        switch jobStatus {
        case .open:
            setColor(color: Colors.skyBlue)
        case .applied:
            setColor(color: Colors.lightGreen)
        case .interview:
            setColor(color: Colors.viewOrange)
        case .closed:
            setColor(color: Colors.blueGrey)
        }
        
        layer.cornerRadius = 10
        backgroundColor = Colors.lightOrange
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
    
    private func setColor(color: UIColor) {
        statusLabel.textColor = color
        numberLabel.textColor = color
        
    }
    
}
