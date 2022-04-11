//
//  AddEditView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class AddEditView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightOrange")
        return view
    }()
    
    let saveJobButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 20)
        button.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
        return button
    }()
    
    private let outerVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
//        stackView.backgroundColor = .blue
        stackView.spacing = 20
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add a new job"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Bold", size: 27)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "status"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: 20)
        return label
    }()
    
    private let statusHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let editOpenButton: EditStatusButtonView = {
       let button = EditStatusButtonView(status: "open", selected: true)
        button.statusButton.isSelected = true
        return button
    }()
    
    let editAppliedButton: EditStatusButtonView = {
       let button = EditStatusButtonView(status: "applied", selected: false)
        return button
    }()
    
    let editInterviewButton: EditStatusButtonView = {
       let button = EditStatusButtonView(status: "interview", selected: false)
        return button
    }()
    
    let editClosedButton: EditStatusButtonView = {
       let button = EditStatusButtonView(status: "closed", selected: false)
        return button
    }()
    
    private let companyField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "company")
        return field
    }()
    
    private let roleField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "role")
        return field
    }()
    
    private let teamField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "team - organization")
        return field
    }()
    
    private let locationField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "location")
        return field
    }()
    
    private let linkField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "link")
        return field
    }()
    
    private let notesField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "notes")
        return field
    }()
    
    private let appliedDateField: LabelAndTextField = {
        let field = LabelAndTextField(labelText: "applied date")
        return field
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpUI()
        setStatusSection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(saveJobButton)
        contentView.addSubview(outerVStackView)
        outerVStackView.addArrangedSubview(titleLabel)
        outerVStackView.addArrangedSubview(statusLabel)
        outerVStackView.addArrangedSubview(statusHStackView)
        
        outerVStackView.addArrangedSubview(companyField)
        outerVStackView.addArrangedSubview(roleField)
        outerVStackView.addArrangedSubview(teamField)
        outerVStackView.addArrangedSubview(locationField)
        outerVStackView.addArrangedSubview(linkField)
        outerVStackView.addArrangedSubview(notesField)
        outerVStackView.addArrangedSubview(appliedDateField)
        
        let scrollFrameGuide = scrollView.frameLayoutGuide
        let scrollContentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),

            saveJobButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            saveJobButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            saveJobButton.heightAnchor.constraint(equalToConstant: 50),
            saveJobButton.widthAnchor.constraint(equalToConstant: 100),
            
            outerVStackView.topAnchor.constraint(equalTo: saveJobButton.bottomAnchor, constant: 10),
            outerVStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            outerVStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            outerVStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusHStackView.heightAnchor.constraint(equalToConstant: 70),
            companyField.heightAnchor.constraint(equalToConstant: 70),
            roleField.heightAnchor.constraint(equalToConstant: 70),
            teamField.heightAnchor.constraint(equalToConstant: 70),
            locationField.heightAnchor.constraint(equalToConstant: 70),
            linkField.heightAnchor.constraint(equalToConstant: 70),
            notesField.heightAnchor.constraint(equalToConstant: 70),
            appliedDateField.heightAnchor.constraint(equalToConstant: 70),

        ])
    }
    
    private func setStatusSection() {
        statusHStackView.addArrangedSubview(editOpenButton)
        statusHStackView.addArrangedSubview(editAppliedButton)
        statusHStackView.addArrangedSubview(editInterviewButton)
        statusHStackView.addArrangedSubview(editClosedButton)
    }
    
}