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
    
    private var wrongAlertView: UIView!
    private var wrongLabel: UILabel!
    
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
        
        wrongAlertView = contentView.wrongAlertView
        wrongLabel = contentView.wrongLabel
        
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
        if !currentPinEntered {
            if let enteredPin = pinTextField.text {
                if enteredPin == keychain.get("ShukatsuPin") {
                    currentPinEntered = true
                    orangeRoundedView.backgroundColor = .systemPurple
                    setLabelText()
                } else {
                    showWrongPinView(text: "Wrong PIN")
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
                    showWrongPinView(text: "Enter 4 Digits")
                }
            }
            pinTextField.text = ""
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
                
            })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.wrongAlertView.alpha = 0
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
