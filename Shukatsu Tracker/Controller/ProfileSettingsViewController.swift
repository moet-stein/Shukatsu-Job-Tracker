//
//  ProfileSettingsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit



class ProfileSettingsViewController: UIViewController {
    private var profile: ProfileSettingsViewModel
    private var pinOn: Bool
    
    private var contentView: ProfileSettingsView!
    private var cancelButton: CancelButton!
    private var profileImageView: UIImageView!
    
    private var imagePicker = UIImagePickerController()
    private var settingsTableView: UITableView!
    private var editProfileCameraButton: CircleButton!
    
    weak var homeVCDelegate: HomeVCDelegate?
    
    private var targetCell: SettingsTableViewCell?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.settingsTableView.indexPathForSelectedRow{
            self.settingsTableView.deselectRow(at: index, animated: true)
        }
    }
    override func loadView() {
        contentView = ProfileSettingsView()
        view = contentView

        cancelButton = contentView.cancelButton
        profileImageView = contentView.profileImageView
        editProfileCameraButton = contentView.editProfileCameraButton
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        settingsTableView = contentView.setttingsTableView
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        addBtnsTarget()
        fetchAndReload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        homeVCDelegate?.updateProfileSettings()
    }
    
    init(profile: ProfileSettingsViewModel, homeVCDelegate: HomeVCDelegate?) {
        self.profile = profile
        self.homeVCDelegate = homeVCDelegate
        self.pinOn = {
            return profile.profilePinOn
        }()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBtnsTarget() {
        editProfileCameraButton.addTarget(self, action: #selector(cameraBtnTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    
    private func fetchAndReload() {
        ProfileSettingsDataManager.fetchProfileSettings { profileData in
            if let profileData = profileData {
                if !profileData.isEmpty {
                    profile = ProfileSettingsViewModel(profileSettings: profileData[0])
                    pinOn = profile.profilePinOn
                    DispatchQueue.main.async { [weak self] in
                        self?.settingsTableView.reloadData()
                        self?.profileImageView.image = self?.profile.profileImage
                    }
                }
            }
        }
    }
    
    @objc func profileImageViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        profileImageView.handleTapShortDuration(gestureRecognizer: tapGestureRecognizer)
        openCameraOrLibrary()
    }
    
    @objc func cameraBtnTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        editProfileCameraButton.handleTapShortDuration(gestureRecognizer: tapGestureRecognizer)
        openCameraOrLibrary()
    }
    
    @objc func cancelBtnTapped(tapGestureRecognizer: UITapGestureRecognizer){
        cancelButton.handleTapShortDuration(gestureRecognizer: tapGestureRecognizer)
        dismiss(animated: true, completion: nil)
    }
    
    private func openCameraOrLibrary() {
        ImagePickerManager().pickImage(self) { [weak self] image in
            
            self?.profileImageView.image = image

            if let profile = self?.profile, let imageData = image.jpegData(compressionQuality: 1.0) {
                ProfileSettingsDataManager.updateProfileImage(profileSettings: profile.profileSettings, profileImage: imageData)
            }
        
        }
    }
    
    private func toggleChangePinCell(isPinOn: Bool, landing: Bool) {
        
        if isPinOn {
            if !landing {
                ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile.profileSettings, profileName: nil, profileTitle: nil, pinOn: true)
                pinOn = true
            }
            targetCell?.titleLabel.textColor = .black
            targetCell?.accessoryType = .disclosureIndicator
        } else {
            if !landing {
                ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile.profileSettings, profileName: nil, profileTitle: nil, pinOn: false)
                pinOn = false
            }
            targetCell?.titleLabel.textColor = .systemGray3
            targetCell?.accessoryType = .none
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
        toggleChangePinCell(isPinOn: isPinOn, landing: false)
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
            case 0: cell.showSetData(retrivedString: profile.profileNameString)
            case 1: cell.showSetData(retrivedString: profile.profileTitleLabelString)
            default: cell.showSetData(retrivedString: "")
            }
        case 1:
            cell.selectionStyle = .none
            
            switch indexPath.row {
            case 0:
                cell.setupCellContent(titleString: settingsContent2[indexPath.row])
                cell.showSwitch(pinIsOn: profile.profilePinOn)
                cell.delegate = self
            case 1:
                cell.setupCellContent(titleString: settingsContent2[indexPath.row])
                cell.accessoryType = .disclosureIndicator
                self.targetCell = cell
                self.toggleChangePinCell(isPinOn: self.profile.profilePinOn, landing: true)
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
                nextVC = SetProfileNameViewController(placeholderText: profile.profileNameString, profileName: true, profileSettingsViewDelegate: self, profile: profile.profileSettings)
            case 1:
                nextVC = SetProfileNameViewController(placeholderText: profile.profileTitleLabelString, profileName: false, profileSettingsViewDelegate: self, profile: profile.profileSettings)
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
                self.pinOn ? present(ChangePinViewController(), animated: true, completion: nil) : print("cannot change pin")
            default:
                return
            }
        default:
            return
        }
    }

}
