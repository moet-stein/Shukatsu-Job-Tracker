//
//  StatusBoxView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class StatusButton: UIButton {
    
    var status: JobStatus
    var buttonColor: UIColor?
    
    
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
        addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNumberForStatus), name: NSNotification.Name("getNumberForStatus"), object: nil)
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
            buttonColor = Colors.skyBlue
        case .applied:
            setColor(color: Colors.lightGreen)
            buttonColor = Colors.lightGreen
        case .interview:
            setColor(color: Colors.viewOrange)
            buttonColor = Colors.viewOrange
        case .closed:
            setColor(color: Colors.blueGrey)
            buttonColor = Colors.blueGrey
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
    
    @objc func statusButtonPressed(sender: UIButton) {
        let button = sender as! StatusButton
        
        sender.isSelected = !sender.isSelected
        
        let tappedCurrentTitle = sender.currentTitle ?? ""
        
        if sender.isSelected {
            UIView.animate(withDuration: 0.5) {
                button.statusLabel.textColor = .white
                button.numberLabel.textColor = .white
                button.backgroundColor = self.buttonColor
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                button.statusLabel.textColor = self.buttonColor
                button.numberLabel.textColor = self.buttonColor
                button.backgroundColor = Colors.lightOrange
            }
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("tappedStatus"), object: nil, userInfo: ["statusName": tappedCurrentTitle, "selected": sender.isSelected])
    }
    
    @objc func getNumberForStatus(notification: Notification) -> Void {
        guard let jobs = notification.userInfo!["jobs"] else { return }
        let number = (jobs as! [JobInfo]).filter{$0.status == self.status.rawValue}.count
        
        numberLabel.text = String(number)
    }
    
}
