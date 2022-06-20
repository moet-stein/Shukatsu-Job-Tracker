//
//  SetProfileNameViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

protocol ProfileSettingsViewDelegate {
    func reloadTableView()
    func toggleChangePINTitle()
}



class SetProfileNameViewController: UIViewController {
    let profile: ProfileSettings
    private var placeholderText: String
    private var profileName: Bool
    
    weak var profileSettingsViewDelegate: ProfileSettingsViewController?
    

    private var contentView: SetProfileNameView!
    private var cancelButton: UIButton!
    private var saveButton: UIButton!
    private var editTextField: UITextField!
    
    init(placeholderText: String, profileName: Bool, profileSettingsViewDelegate: ProfileSettingsViewController?, profile: ProfileSettings) {
        self.placeholderText = placeholderText
        self.profileName = profileName
        self.profileSettingsViewDelegate = profileSettingsViewDelegate
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.lightOrange
        
        contentView = SetProfileNameView()
        view = contentView
        cancelButton = contentView.cancelButton
        saveButton = contentView.saveButton
        editTextField = contentView.editTextField
        editTextField.delegate = self
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        contentView.setUpContent(placeholderText: placeholderText)
    }
    



    @objc func saveButtonTapped() {
        let newProfileString = editTextField.text
        let profileNameString: String?
        let profileTitleString: String?
        
        if profileName {
            profileNameString = newProfileString
            profileTitleString = nil
        } else {
            profileNameString = nil
            profileTitleString = newProfileString
        }
        
        
        ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: profileNameString, profileTitle: profileTitleString, pinOn: nil)
        
        DispatchQueue.main.async { [weak self] in
            self?.profileSettingsViewDelegate?.reloadTableView()
        }
            
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension SetProfileNameViewController: UITextFieldDelegate {
    
}
