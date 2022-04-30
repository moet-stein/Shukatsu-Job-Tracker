//
//  EnterPinView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 01.04.22.
//

import UIKit
//import KeychainSwift

class EnterPinView: UIView {
    
    private let orangeRoundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "viewOrange")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let enterPinTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        let keychain = KeychainSwift()
//        label.text = {
//            if keychain.get("ShukatsuPin") == nil {
//                return "Set a Pin"
//            } else {
//                return "Enter Your Pin"
//            }
//        }()
        label.font = UIFont(name: "Lato-Bold", size: 25)
        label.textColor = UIColor(named: "bgOffwhite")
        return label
    }()
    
    let pinTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " 4 digit PIN"
        textField.keyboardType = .asciiCapableNumberPad
        textField.textAlignment = .center
        textField.tintColor = UIColor(named: "viewOrange")
        textField.backgroundColor = UIColor(named: "bgOffwhite")
        textField.layer.cornerRadius = 10
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return textField
    }()
    
    lazy var goButton: CircleButton = {
        let button = CircleButton(
            buttonSize: 50,
            bgColor: UIColor(red: 0.64, green: 0.82, blue: 1.00, alpha: 1.00),
            buttonText: "GO",
            sfSymbolName: nil)
        
        return button
    }()
    
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
            orangeRoundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            orangeRoundedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            orangeRoundedView.widthAnchor.constraint(equalToConstant: 300),
            orangeRoundedView.heightAnchor.constraint(equalToConstant: 200)
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
        
        vStackView.addArrangedSubview(enterPinTitleLabel)
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
