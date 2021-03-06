//
//  SettingsTableViewCell.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

protocol SettingsTableViewCellDelegate: AnyObject {
    func settingsTableViewCell(_ settingsTableViewCell: SettingsTableViewCell, isPinOn: Bool)
}

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    
    weak var delegate: SettingsTableViewCellDelegate?
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoRegular, size: 17)
        return label
    }()
    
    let setDataString: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoRegular, size: 15)
        label.textColor = UIColor.systemGray
        return label
    }()
    
    lazy var pinSwitch: UISwitch = {
        let switchButton = UISwitch()
        switchButton.addTarget(self, action: #selector(switchTriggered), for: .valueChanged)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return switchButton
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    
    func setupCellContent(titleString: String) {
        titleLabel.text = titleString
    }
    
    func showSetData(retrivedString: String) {
        setDataString.text = retrivedString
        contentView.addSubview(setDataString)
        
        NSLayoutConstraint.activate([
            setDataString.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setDataString.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
        
        accessoryType = .disclosureIndicator
    }
    
    func showSwitch(pinIsOn: Bool) {
        pinSwitch.isOn = pinIsOn
        
        contentView.addSubview(pinSwitch)
        NSLayoutConstraint.activate([
            pinSwitch.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            pinSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pinSwitch.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
    }
    
    @objc func switchTriggered(sender: UISwitch) {
        self.delegate?.settingsTableViewCell(self, isPinOn: sender.isOn)
    }
}


