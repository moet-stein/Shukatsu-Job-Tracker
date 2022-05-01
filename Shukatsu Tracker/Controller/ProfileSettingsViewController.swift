//
//  ProfileSettingsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit



class ProfileSettingsViewController: UIViewController {
    
    
    private var profile = ProfileSettings()
    
    private var contentView: ProfileSettingsView!
    private var profileImageView: UIImageView!
    
    private var imagePicker = UIImagePickerController()
    private var settingsTableView: UITableView!
    private var editProfileCameraButton: CircleButton!
    
    weak var homeVCDelegate: HomeVCDelegate?
    
    private var targetCell: SettingsTableViewCell?
    
    
    override func loadView() {
        contentView = ProfileSettingsView()
        view = contentView

        profileImageView = contentView.profileImageView
        editProfileCameraButton = contentView.editProfileCameraButton
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        settingsTableView = contentView.setttingsTableView
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        addCameraBtnTarget()
        fetchAndReload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        homeVCDelegate?.updateProfileSettings()
    }
    
    init(homeVCDelegate: HomeVCDelegate?) {
        self.homeVCDelegate = homeVCDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCameraBtnTarget() {
        editProfileCameraButton.addTarget(self, action: #selector(cameraBtnTapped), for: .touchUpInside)
    }
    
    
    private func fetchAndReload() {
        ProfileSettingsDataManager.fetchProfileSettings { profileData in
            if let profileData = profileData {
                if !profileData.isEmpty {
                    profile = profileData[0]
                    
                    var uiImage = UIImage(named: "azuImage")!
                    
                    if let image = profile.profileImage {
                        uiImage = UIImage(data: image)!
                    }

                    DispatchQueue.main.async { [weak self] in
                        self?.settingsTableView.reloadData()
                        self?.profileImageView.image = uiImage
                    }
                }
            }
        }
    }
    
    @objc func profileImageViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        openCameraOrLibrary()
    }
    
    @objc func cameraBtnTapped() {
        openCameraOrLibrary()
    }
    
    private func openCameraOrLibrary() {
        ImagePickerManager().pickImage(self) { [weak self] image in
            
            self?.profileImageView.image = image

            if let profile = self?.profile, let imageData = image.jpegData(compressionQuality: 1.0) {
                ProfileSettingsDataManager.updateProfileImage(profileSettings: profile, profileImage: imageData)
            }
        
        }
    }
    
    

}

extension ProfileSettingsViewController: ProfileSettingsViewDelegate {
    func reloadTableView() {
        self.fetchAndReload()
    }
    
    func toggleChangePINTitle() {
        print("toggleChangePINTitle")
    }
}

extension ProfileSettingsViewController: SettingsTableViewCellDelegate {
    func settingsTableViewCell(_ settingsTableViewCell: SettingsTableViewCell, isPinOn: Bool) {
        if isPinOn {
            ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: nil, profileTitle: nil, pinOn: true)
            targetCell?.titleLabel.textColor = .black
            targetCell?.accessoryType = .disclosureIndicator
        } else {
            ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: nil, profileTitle: nil, pinOn: false)
            targetCell?.titleLabel.textColor = .systemGray3
            targetCell?.accessoryType = .none
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
        case 0:
            cell.setupCellContent(titleString: settingsContent1[indexPath.row])
            switch indexPath.row {
            case 0: cell.showSetData(retrivedString: profile.profileName ?? "")
            case 1: cell.showSetData(retrivedString: profile.profileTitle ?? "")
            default: cell.showSetData(retrivedString: "")
            }
        case 1:
            cell.selectionStyle = .none
            
            switch indexPath.row {
            case 0:
                cell.setupCellContent(titleString: settingsContent2[indexPath.row])
                cell.showSwitch(pinIsOn: profile.pinOn)
                cell.delegate = self
            case 1:
                cell.setupCellContent(titleString: settingsContent2[indexPath.row])
                cell.accessoryType = .disclosureIndicator
                self.targetCell = cell
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
            switch indexPath.row {
            case 0:
                return
            case 1:
                if profile.pinOn {
                    present(ChangePinViewController(), animated: true, completion: nil)
                } else {
                    print("cannot change pin")
                }
            default:
                return
            }
        default:
            return
        }
    }
}
