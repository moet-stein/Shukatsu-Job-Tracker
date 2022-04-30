//
//  ChangePinViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 30.04.22.
//

import UIKit
import KeychainSwift
import CoreData

class ChangePinViewController: UIViewController {

    private var contentView: EnterPinView!
    private var pinTextField: UITextField!
    private var goButton: UIButton!
    private var enterPinTitleLabel: UILabel!
    private var orangeRoundedView: UIView!
    
    private var currentPinEntered:Bool = false
    
    let keychain = KeychainSwift()
    
    override func loadView() {
        contentView = EnterPinView()
        view = contentView
        
        pinTextField = contentView.pinTextField
        pinTextField.delegate = self
        
        goButton = contentView.goButton
        goButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        enterPinTitleLabel = contentView.enterPinTitleLabel
        orangeRoundedView = contentView.orangeRoundedView
        
        setLabelText()
    }
    
    private func setLabelText() {
        if currentPinEntered {
            enterPinTitleLabel.text = "Set NEW PIN"
        } else {
            enterPinTitleLabel.text = "Enter Current PIN"
        }
    }
    
    @objc func buttonPressed() {
        //check if user is asked to type current or new pin
        //if current,1
        //if new pin, set the new pin, updating Shukatsu pin
        if !currentPinEntered {
            //type current pin
            if let enteredPin = pinTextField.text {
                //1. compare the saved pin from Keychain and the entered pin
                //if correct change the title and let user type new pin
                if enteredPin == keychain.get("ShukatsuPin") {
                    currentPinEntered = true
                    orangeRoundedView.backgroundColor = .systemPurple
                } else {
                    print("wrong pin")
                }
                pinTextField.text = ""
                setLabelText()
            }
        } else {
            //type new pin
            if let enteredPin = pinTextField.text {
                //update the pin
                if enteredPin.count == 4 {
                    print("Updated new pin")
                } else {
                    print("4 digit needed")
                }
            }
        }
    }
}

extension ChangePinViewController: UITextFieldDelegate {
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
