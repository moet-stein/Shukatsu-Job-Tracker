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
    private var enterPinTitleLabel: UILabel!
    private var wrongAlertView: UIView!
    private var wrongLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let keychain = KeychainSwift()
    
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
        
        enterPinTitleLabel = contentView.enterPinTitleLabel
        
        pinTextField = contentView.pinTextField
        pinTextField.delegate = self
        
        goButton = contentView.goButton
        goButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        wrongAlertView = contentView.wrongAlertView
        wrongLabel = contentView.wrongLabel
        
//        createTestJobInfo()
        setLabelText()
    }
    
    private func setLabelText() {
        enterPinTitleLabel.text = {
            if keychain.get("ShukatsuPin") == nil {
                return "Set Pin"
            } else {
                return "Enter Your Pin"
            }
        }()
    }
    
    @objc func buttonPressed() {
        if let enteredPin = pinTextField.text {
            if keychain.get("ShukatsuPin") == nil {
                if enteredPin.count == 4 {
                    let saveSuccessful: Bool = keychain.set(enteredPin, forKey: "ShukatsuPin")
                    createProfile()
                    print(saveSuccessful)
                    navigationController?.pushViewController(HomeViewController(), animated: true)
                } else {
                    showWrongPinView(text: "Enter 4 Digits")
                }
            } else {
                if enteredPin == keychain.get("ShukatsuPin") {
                    createProfile()
                    navigationController?.pushViewController(HomeViewController(), animated: true)
                } else {
                    showWrongPinView(text: "Wrong PIN")
                }
            }
            pinTextField.text = ""
        }
    }
    
//    private func createTestJobInfo() {
//        JobInfoDataManager.fetchJonInfos { jobs in
//            if let jobs = jobs {
//
//                if jobs.isEmpty {
//                    JobInfoDataManager.createJobInfo(delegate: HomeViewController(), companyName: "Test", location: "Berlin", status: "applied", favorite: true, role: "iOS Engineer", team: "iOS team", link: "https://www.google.com/", notes: "notes", appliedDate: Date(), lastUpdate: Date())
//                    JobInfoDataManager.createJobInfo(delegate: HomeViewController(), companyName: "Test2", location: "Berlin", status: "interview", favorite: false, role: "iOS Developer", team: "N/A", link: "https://www.apple.com/", notes: "notes", appliedDate: Date(), lastUpdate: Date())
//                }
//            }
//        }
//    }
    
    private func createProfile() {
        ProfileSettingsDataManager.fetchProfileSettings { profiles in
            if let profiles = profiles {
                if profiles.isEmpty{
                    ProfileSettingsDataManager.createProfileSettings(profileName: "Unknown", profileTitle: "unknown title", pinOn: true)
                } else {
                    print("its not empty")
                }
            }
        }
    }
    
    private func showWrongPinView(text: String) {
        wrongAlertView.isHidden = false
        wrongAlertView.alpha = 1
        wrongLabel.text = text
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                
                self.wrongAlertView.frame.origin.x = 100
                
            }) { (completed) in
                
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.wrongAlertView.alpha = 0
                self.wrongAlertView.frame.origin.x = 0
            }
        }
    }
    
}

extension EnterPinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
     
        
        // make sure the result is under 4 characters
        return updatedText.count <= 4 && allowedCharacters.isSuperset(of: characterSet)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
