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
    private var cancelButton: CancelButton!
    private var pinTextField: UITextField!
    private var goButton: UIButton!
    private var enterPinTitleLabel: UILabel!
    private var orangeRoundedView: UIView!
    
    private var currentPinEntered:Bool = false
    
    let keychain = KeychainSwift()
    
    override func loadView() {
        contentView = EnterPinView()
        view = contentView
        
        cancelButton = contentView.cancelButton
        cancelButton.isHidden = false
        
        pinTextField = contentView.pinTextField
        pinTextField.delegate = self
        
        goButton = contentView.goButton
        goButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        enterPinTitleLabel = contentView.enterPinTitleLabel
        orangeRoundedView = contentView.orangeRoundedView
        
        setLabelText()
        addCancelBtnTarget()
    }
    
    private func setLabelText() {
        if currentPinEntered {
            enterPinTitleLabel.text = "Set NEW PIN"
        } else {
            enterPinTitleLabel.text = "Enter Current PIN"
        }
    }
    
    private func addCancelBtnTarget() {
        cancelButton.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    @objc func cancelBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonPressed() {
        if !currentPinEntered {
            if let enteredPin = pinTextField.text {
                if enteredPin == keychain.get("ShukatsuPin") {
                    currentPinEntered = true
                    orangeRoundedView.backgroundColor = .systemPurple
                    setLabelText()
                } else {
                    contentView.showWrongPinView(text: "Wrong PIN")
                    contentView.shakeTextField(textField: pinTextField)
                }
                pinTextField.text = ""
                
            }
        } else {
            //type new pin
            if let enteredPin = pinTextField.text {
                //update the pin
                if enteredPin.count == 4 {
                    keychain.set(enteredPin, forKey: "ShukatsuPin")
                    dismiss(animated: true)
                } else {
                    contentView.showWrongPinView(text: "Enter 4 Digits")
                    contentView.shakeTextField(textField: pinTextField)
                }
            }
            pinTextField.text = ""
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
