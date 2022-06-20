//
//  SetProfileNameView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 20.06.22.
//

import UIKit

class SetProfileNameView: UIView {

    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        return button
    }()
    
    private let textFieldView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let editTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.tintColor = .systemOrange
        return textField
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
        addSubview(saveButton)
        addSubview(textFieldView)
        textFieldView.addSubview(editTextField)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            textFieldView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 100),
            textFieldView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldView.widthAnchor.constraint(equalToConstant: 250),
            textFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            editTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor),
            editTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 20),
            editTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -20),
            editTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor)
        ])
    }
    
    func setUpContent(placeholderText: String) {
        editTextField.text = placeholderText
    }

}
