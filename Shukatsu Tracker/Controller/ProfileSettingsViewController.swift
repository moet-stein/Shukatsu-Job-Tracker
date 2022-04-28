//
//  ProfileSettingsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    private var contentView: ProfileSettingsView!
    private var setttingsTableView: UITableView!
    
    override func loadView() {
        contentView = ProfileSettingsView()
        view = contentView
        setttingsTableView = contentView.setttingsTableView
        setttingsTableView.delegate = self
        setttingsTableView.dataSource = self
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        
        let settingsContent1 = ["Name", "Title"]
        let settingsContent2 = ["PIN", "Change PIN"]
        
            switch indexPath.section {
            case 0:  // Section 0 Setup
                cell.setupCellContent(titleString: settingsContent1[indexPath.row])
                switch indexPath.row {
                    case 0: cell.showSetData(retrivedString: "Moe")
                    case 1: cell.showSetData(retrivedString: "Future iOS Engineer")
                    default: cell.showSetData(retrivedString: "")
                }
            case 1:
                cell.selectionStyle = .none
                cell.setupCellContent(titleString: settingsContent2[indexPath.row])
                switch indexPath.row {
                case 0: cell.showSwitch(pinIsOn: true)
                case 1:
                    cell.accessoryType = .disclosureIndicator
                default: cell.textLabel?.text = ""
                    
                }
            default: break
            }
        
        return cell
    }
    
    
}

extension ProfileSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileData = ["Moe", "Future iOS Engineer"]
        switch indexPath.section {
        case 0:
            let nextVC = SetProfileNameViewController(placeholderText: profileData[indexPath.row])
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true, completion: nil)
            print("Selected name or title cell")
        case 1:
            print("selected pin field")
        default:
            return
        }
    }
}
