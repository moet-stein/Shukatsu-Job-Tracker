//
//  EnterPinView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 01.04.22.
//

import UIKit
//import KeychainSwift

class EnterPinView: UIView {
    
    let wrongAlertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = .systemRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemRed.cgColor
        return view
    }()
    
    let cancelButton: CancelButton = {
        let button = CancelButton(buttonColor: Colors.viewOrange)
        button.isHidden = true
        return button
    }()
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoBold, size: 23)
        label.textColor = .white
        return label
    }()
    
    let orangeRoundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.viewOrange
        view.layer.cornerRadius = 20
        return view
    }()
    
    let enterPinTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoBold, size: 25)
        label.textColor = Colors.bgOffwhite
        return label
    }()
    
    let pinTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " 4 digit PIN"
        textField.keyboardType = .asciiCapableNumberPad
        textField.textAlignment = .center
        textField.tintColor = Colors.viewOrange
        textField.backgroundColor = Colors.bgOffwhite
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
        backgroundColor = Colors.bgOffwhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(cancelButton)
        addSubview(orangeRoundedView)
        addSubview(wrongAlertView)
        wrongAlertView.addSubview(wrongLabel)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            orangeRoundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            orangeRoundedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            orangeRoundedView.widthAnchor.constraint(equalToConstant: 300),
            orangeRoundedView.heightAnchor.constraint(equalToConstant: 200),
            
            wrongAlertView.bottomAnchor.constraint(equalTo: orangeRoundedView.topAnchor, constant: -30),
            wrongAlertView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrongAlertView.widthAnchor.constraint(equalToConstant: 180),
            wrongAlertView.heightAnchor.constraint(equalToConstant: 40),
            
            wrongLabel.topAnchor.constraint(equalTo: wrongAlertView.topAnchor),
            wrongLabel.leadingAnchor.constraint(equalTo: wrongAlertView.leadingAnchor, constant: 10),
            wrongLabel.bottomAnchor.constraint(equalTo: wrongAlertView.bottomAnchor)
            
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
