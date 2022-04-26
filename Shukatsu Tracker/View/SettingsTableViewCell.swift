//
//  SettingsTableViewCell.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Lato-Regular", size: 17)
        return label
    }()
    
    let setDataString: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont(name: "Lato-Regular", size: 15)
        label.textColor = UIColor.systemGray
         return label
    }()
    
    private let uiSwitch: UISwitch = {
       let switchButton = UISwitch()
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
        addSubview(titleLabel)
        
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
        addSubview(setDataString)
        
        NSLayoutConstraint.activate([
            setDataString.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setDataString.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
        
        accessoryType = .disclosureIndicator
    }
    
    func showSwitch(pinIsOn: Bool) {
        addSubview(uiSwitch)
        
        NSLayoutConstraint.activate([
            uiSwitch.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            uiSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            uiSwitch.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        if pinIsOn {
            uiSwitch.isOn = true 
        }
    }

}
