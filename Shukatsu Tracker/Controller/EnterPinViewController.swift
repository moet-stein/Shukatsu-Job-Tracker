//
//  ViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 01.04.22.
//

import UIKit
import KeychainSwift
import CoreData

class EnterPinViewController: UIViewController {
    private var contentView: EnterPinView!
    private var pinTextField: UITextField!
    private var goButton: UIButton!
    
    let defaults = UserDefaults.standard
    let keychain: KeychainSwift
    
    
    init(keychain: KeychainSwift) {
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard defaults.object(forKey: "firstTime") != nil else {
            defaults.set(false, forKey: "firstTime")
            ProfileSettingsDataManager.createProfileSettings(profileName: "Unknown", profileTitle: "unknown title", pinOn: true)
            return
        }
    }
    
    override func loadView() {
        contentView = EnterPinView()
        view = contentView
        
        pinTextField = contentView.pinTextField
        pinTextField.delegate = self
        
        goButton = contentView.goButton
        goButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        setLabelText()
    }
    
    private func setLabelText() {
        if keychain.get("ShukatsuPin") == nil {
            contentView.enterPinViewSetLabel(keyChainExist: false)
        } else {
            contentView.enterPinViewSetLabel(keyChainExist: true)
        }
    }
    
    @objc func buttonPressed() {
        guard let enteredPin = pinTextField.text else {
            return
        }
        
        guard (keychain.get("ShukatsuPin") != nil) else {
            if enteredPin.count == 4 {
                let _: Bool = keychain.set(enteredPin, forKey: "ShukatsuPin")
                createProfile()

                navigationController?.pushViewController(HomeViewController(), animated: true)
            } else {
                contentView.showWrongPinView(text: "Enter 4 Digits")
                contentView.shakeTextField(textField: pinTextField)
            }
            return
        }
        
        if enteredPin == keychain.get("ShukatsuPin") {
            createProfile()
            navigationController?.pushViewController(HomeViewController(), animated: true)
        } else {
            contentView.showWrongPinView(text: "Wrong PIN")
            contentView.shakeTextField(textField: pinTextField)
        }
        
        pinTextField.text = ""

    }
    
    private func createProfile() {
        ProfileSettingsDataManager.fetchProfileSettings { profiles in
            if let profiles = profiles {
                if profiles.isEmpty {
                    ProfileSettingsDataManager.createProfileSettings(profileName: "Unknown", profileTitle: "unknown title", pinOn: true)
                }
            }
        }
    }
    
}

extension EnterPinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return updatedText.count <= 4 && allowedCharacters.isSuperset(of: characterSet)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
