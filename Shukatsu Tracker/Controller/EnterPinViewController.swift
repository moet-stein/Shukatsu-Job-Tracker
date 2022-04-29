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
    let keychain = KeychainSwift()
    
    override func loadView() {
        contentView = EnterPinView()
        view = contentView
        
        pinTextField = contentView.pinTextField
        pinTextField.delegate = self
        
        goButton = contentView.goButton
        goButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        createTestJobInfo()
    }
    
    @objc func buttonPressed() {
        if let enteredPin = pinTextField.text {
            if keychain.get("ShukatsuPin") == nil {
                let saveSuccessful: Bool = keychain.set(enteredPin, forKey: "ShukatsuPin")
                print("saveSuccessful: \(saveSuccessful)")
                createProfile()
                navigationController?.pushViewController(HomeViewController(), animated: true)
            } else {
                if enteredPin == keychain.get("ShukatsuPin") {
                    print("corrent pin \(enteredPin)")
                    createProfile()
                    navigationController?.pushViewController(HomeViewController(), animated: true)
                } else {
                    print("wrong pin")
                }
            }
            pinTextField.text = ""
        }
        
        

    }
    
    private func createTestJobInfo() {
        JobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs {
                
                if jobs.isEmpty {
                    JobInfoDataManager.createJobInfo(delegate: HomeViewController(), companyName: "Test", location: "Berlin", status: "applied", favorite: true, role: "iOS Engineer", team: "iOS team", link: "https://www.google.com/", notes: "notes", appliedDate: Date(), lastUpdate: Date())
                    JobInfoDataManager.createJobInfo(delegate: HomeViewController(), companyName: "Test2", location: "Berlin", status: "interview", favorite: false, role: "iOS Developer", team: "N/A", link: "https://www.apple.com/", notes: "notes", appliedDate: Date(), lastUpdate: Date())
                }
            }
        }
    }
    
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
