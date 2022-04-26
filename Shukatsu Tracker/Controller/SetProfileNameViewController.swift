//
//  SetProfileNameViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

class SetProfileNameViewController: UIViewController {
    private var placeholderText: String
    
    lazy var goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let textFieldView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let editTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.tintColor = .systemOrange
        return textField
    }()
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lightOrange")
        editTextField.delegate = self
        setUpUI()
        setUpContent()
    }
    

    private func setUpUI() {
        view.addSubview(goBackButton)
        view.addSubview(textFieldView)
        textFieldView.addSubview(editTextField)
        
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            goBackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textFieldView.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 100),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldView.widthAnchor.constraint(equalToConstant: 250),
            textFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            editTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor),
            editTextField.leftAnchor.constraint(equalTo: textFieldView.leftAnchor, constant: 20),
            editTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor)
        ])
    }
    
    private func setUpContent() {
        editTextField.text = placeholderText
    }

    @objc func goBackButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension SetProfileNameViewController: UITextFieldDelegate {
    
}
