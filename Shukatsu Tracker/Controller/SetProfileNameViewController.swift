//
//  SetProfileNameViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

class SetProfileNameViewController: UIViewController {
    private var placeholderText: String
    private var profileName: Bool
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let textFieldView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let editTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.tintColor = .systemOrange
        return textField
    }()
    
    init(placeholderText: String, profileName: Bool) {
        self.placeholderText = placeholderText
        self.profileName = profileName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lightOrange")
        editTextField.delegate = self
        setUpUI()
        setUpContent()
    }
    

    private func setUpUI() {
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        view.addSubview(textFieldView)
        textFieldView.addSubview(editTextField)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            textFieldView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 100),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldView.widthAnchor.constraint(equalToConstant: 250),
            textFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            editTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor),
            editTextField.leftAnchor.constraint(equalTo: textFieldView.leftAnchor, constant: 20),
            editTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor)
        ])
    }
    
    private func setUpContent() {
        editTextField.text = placeholderText
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
        
        ProfileSettingsDataManager.fetchProfileSetting(usingString: placeholderText, profileName: profileName
        ) { profile in
            if let profile = profile {
                ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: profileNameString, profileTitle: profileTitleString, pinOn: nil)
                
                DispatchQueue.main.async {
                    //reload static tableview
                }
            }
            
        }
        
//        if profileTitle {
//            ProfileSettingsDataManager.fetchProfileSetting(usingString: placeholderText, profileName: true) { profile in
//                if let profile = profile {
//                    ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: newProfileString, profileTitle: nil, pinOn: nil)
//
//                    DispatchQueue.main.async {
//                        //reload static tableview
//                    }
//                }
//
//            }
//        } else {
//            ProfileSettingsDataManager.fetchProfileSetting(usingString: placeholderText, profileName: false) { profile in
//                if let profile = profile {
//                    ProfileSettingsDataManager.updateProfileSettings(profileSettings: profile, profileName: nil, profileTitle: newProfileString, pinOn: nil)
//
//                    DispatchQueue.main.async {
//                        //reload static tableview
//                    }
//                }
//            }
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension SetProfileNameViewController: UITextFieldDelegate {
    
}
