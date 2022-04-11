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
        label.font = UIFont(name: "Lato-Regular", size: 20)
        label.textColor = .black
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = UIColor(named: "viewOrange")
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 7
//        let endPosition = textField.endOfDocument
//        textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
        return textField
    }()
    
    
    init(labelText: String, frame: CGRect = .zero) {
        self.labelText = labelText
        super.init(frame: frame)
        self.setUpUI()
        self.setContent()
        
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(vStackView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //            vStackView.widthAnchor.constraint(equalToConstant: 500),
//            vStackView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func setContent(){
        titleLabel.text = labelText
    }
    
}


extension LabelAndTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let arbitraryValue: Int = 5
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: arbitraryValue) {
            print(newPosition)
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
    }
}
