//
//  ProfileSettingsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class ProfileSettingsViewController: UIViewController, ProfileSettingsViewDelegate {
    
    private var profile = ProfileSettings()
    
    private var contentView: ProfileSettingsView!
    private var settingsTableView: UITableView!
    
    
    override func loadView() {
        print("loadview")
        contentView = ProfileSettingsView()
        view = contentView
        settingsTableView = contentView.setttingsTableView
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        fetchAndReload()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTableView() {
        self.fetchAndReload()
    }
    
    
    private func fetchAndReload() {
        
        ProfileSettingsDataManager.fetchProfileSettings { profileData in
            if let profileData = profileData {
                profile = profileData[0]

                DispatchQueue.main.async { [weak self] in
                    self?.settingsTableView.reloadData()
                }
            
            }
        }
    }

}

extension ProfileSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name and Title"
        case 1:
            return "PIN setting"
        default:
            return "Section \(section)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
//            return UITableViewCell()
//        }

        let cell = SettingsTableViewCell()

        
        let settingsContent1 = ["Name", "Title"]
        let settingsContent2 = ["PIN", "Change PIN"]
        
        switch indexPath.section {
        case 0:  // Section 0 Setup
            cell.setupCellContent(titleString: settingsContent1[indexPath.row])
            switch indexPath.row {
            case 0: cell.showSetData(retrivedString: profile.profileName ?? "")
            case 1: cell.showSetData(retrivedString: profile.profileTitle ?? "")
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
        switch indexPath.section {
        case 0:
            let nextVC: SetProfileNameViewController
            switch indexPath.row {
            case 0:
                nextVC = SetProfileNameViewController(placeholderText: profile.profileName ?? "", profileName: true, profileSettingsViewDelegate: self)
            case 1:
                nextVC = SetProfileNameViewController(placeholderText:profile.profileTitle ?? "", profileName: false, profileSettingsViewDelegate: self)
            default:
                return
            }
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true, completion: nil)
        case 1:
            print("selected pin field")
        default:
            return
        }
    }
}
