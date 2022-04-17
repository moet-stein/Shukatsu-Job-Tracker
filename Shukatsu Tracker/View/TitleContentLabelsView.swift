//
//  TitleContentLabelsView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 17.04.22.
//

import UIKit

class TitleContentLabelsView: UIView {

    var titleText: String
    var contentText: String
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(titleText: String, contentText: String, frame: CGRect = .zero) {
        self.titleText = titleText
        self.contentText = contentText
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
        vStackView.addArrangedSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            contentLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func setContent(){
        titleLabel.text = titleText
        contentLabel.text = contentText
    }
    
    func addStatusContent() {
        
    }

}
