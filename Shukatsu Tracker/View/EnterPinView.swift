//
//  EnterPinView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 01.04.22.
//

import UIKit
import SwiftKeychainWrapper

class EnterPinView: UIView {
    
    private let orangeRoundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "viewOrange")
        view.layer.cornerRadius = 20
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = {
            if KeychainWrapper.standard.string(forKey: "SecretPin") == nil {
                return "Set a Pin"
            } else {
                return "Enter Your Pin"
            }
        }()
        label.font = UIFont(name: "Lato-Bold", size: 25)
        label.textColor = UIColor(named: "bgOffwhite")
        return label
    }()
    
    let pinTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " 4 digit PIN"
        textField.keyboardType = .asciiCapableNumberPad
        textField.backgroundColor = UIColor(named: "bgOffwhite")
        textField.layer.cornerRadius = 10
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return textField
    }()
    
    lazy var goButton: GoButton = {
        let button = GoButton(buttonSize: 50)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonPressed() {
        if let enteredPin = pinTextField.text {
            if KeychainWrapper.standard.string(forKey: "SecretPin") == nil {
                let saveSuccessful: Bool = KeychainWrapper.standard.set(enteredPin, forKey: "SecretPin")
                print("saveSuccessful: \(saveSuccessful)")
            } else {
                enteredPin == KeychainWrapper.standard.string(forKey: "SecretPin") ? print("corrent pin \(enteredPin)") : print("wrong pin")
            }
        }
//        let saveSuccessful: Bool = KeychainWrapper.standard.set("firstTry", forKey: "SecretPin")
//        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SecretPin")
//        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "SecretPin")

    }
    
    init() {
        super.init(frame: .zero)
        setUpUI()
        backgroundColor = UIColor(named: "bgOffwhite")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(orangeRoundedView)
        
        NSLayoutConstraint.activate([
            orangeRoundedView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            orangeRoundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        setUpInsideOrangeView()
    }
    
    private func setUpInsideOrangeView() {
        let vStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fillProportionally
            stackView.spacing = 15
            return stackView
        }()
        orangeRoundedView.addSubview(vStackView)
        
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(pinTextField)
        vStackView.addArrangedSubview(goButton)
        
        
        NSLayoutConstraint.activate([
            vStackView.centerXAnchor.constraint(equalTo: orangeRoundedView.centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: orangeRoundedView.centerYAnchor),
            vStackView.widthAnchor.constraint(equalTo: orangeRoundedView.widthAnchor, multiplier: 0.8),
            vStackView.heightAnchor.constraint(equalTo: orangeRoundedView.heightAnchor, multiplier: 0.8)
        ])
        
    }
    
}
