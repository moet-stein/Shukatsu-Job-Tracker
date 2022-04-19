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
    }
    
    @objc func buttonPressed() {
        if let enteredPin = pinTextField.text {
            if keychain.get("ShukatsuPin") == nil {
                let saveSuccessful: Bool = keychain.set(enteredPin, forKey: "ShukatsuPin")
                print("saveSuccessful: \(saveSuccessful)")
                navigationController?.pushViewController(HomeViewController(jobs: Jobs()), animated: true)
            } else {
                if enteredPin == keychain.get("ShukatsuPin") {
                    print("corrent pin \(enteredPin)")
                    navigationController?.pushViewController(HomeViewController(jobs: Jobs()), animated: true)
                } else {
                    print("wrong pin")
                }
            }
            pinTextField.text = ""
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
