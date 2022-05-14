//
//  LabelAndTextField.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.04.22.
//

import UIKit

class LabelAndTextField: UIView {
    
    
    var labelText: String
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.latoRegular, size: 20)
        label.textColor = .black
        return label
    }()
    
    private let textFieldBGView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = Colors.viewOrange
        textField.backgroundColor = .clear
        return textField
    }()
    
    
    init(labelText: String, frame: CGRect = .zero) {
        self.labelText = labelText
        super.init(frame: frame)
        self.setUpUI()
        self.setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(vStackView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(textFieldBGView)
        textFieldBGView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            textFieldBGView.heightAnchor.constraint(equalToConstant: 40),
            
            textField.topAnchor.constraint(equalTo: textFieldBGView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: textFieldBGView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: textFieldBGView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldBGView.bottomAnchor)
            
        ])
    }
    
    private func setContent(){
        titleLabel.text = labelText
    }
}

