//
//  JobDetailsView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class JobDetailsView: UIView {
    
    private var selectedJob: JobInfo

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "lightOrange")
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightOrange")
        return view
    }()
    // MARK: - Buttons
    private let buttonsHStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        let heartSF = UIImage(systemName: "heart", withConfiguration: config)
        button.tintColor = UIColor(named: "viewOrange")
        button.setImage(heartSF, for: .normal)
        return button
    }()
    
    let detailViewEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 25)
        return button
    }()
    
    // MARK: - Contents
    
    private let contentVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    let statusLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "status", boldText: true)
        return view
    }()
    
    let companyLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "company", boldText: true)
        return view
    }()
    
    let roleLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "role", boldText: true)
        return view
    }()
    
    let teamLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "team", boldText: true)
        return view
    }()
    
    let locationLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "location", boldText: true)
        return view
    }()
    
    let linkLabels: TitleLinkView = {
       let view = TitleLinkView(titleText: "link")
        return view
    }()
    
    let notesLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "notes", boldText: false)
        return view
    }()
    
    let appliedDateLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "applied date", boldText: false)
        return view
    }()
    
    let lastUpdatedLabels: TitleContentLabelsView = {
       let view = TitleContentLabelsView(titleText: "last updated", boldText: false)
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("DELETE", for: .normal)
        
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.systemRed, for: .normal)
        return button
    }()

    
    init(selectedJob: JobInfo) {
        self.selectedJob = selectedJob
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(buttonsHStackView)
        buttonsHStackView.addArrangedSubview(favoriteButton)
        buttonsHStackView.addArrangedSubview(detailViewEditButton)
        
        contentView.addSubview(contentVStackView)
        contentVStackView.addArrangedSubview(statusLabels)
        contentVStackView.addArrangedSubview(companyLabels)
        contentVStackView.addArrangedSubview(roleLabels)
        contentVStackView.addArrangedSubview(teamLabels)
        contentVStackView.addArrangedSubview(locationLabels)
        contentVStackView.addArrangedSubview(linkLabels)
        contentVStackView.addArrangedSubview(notesLabels)
        contentVStackView.addArrangedSubview(appliedDateLabels)
        contentVStackView.addArrangedSubview(lastUpdatedLabels)
        
        contentView.addSubview(deleteButton)
    
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
            
            buttonsHStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            buttonsHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            buttonsHStackView.widthAnchor.constraint(equalToConstant: 130),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            contentVStackView.topAnchor.constraint(equalTo: buttonsHStackView.bottomAnchor, constant: 30),
            contentVStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            contentVStackView.widthAnchor.constraint(equalToConstant: 320),
//            contentVStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            statusLabels.heightAnchor.constraint(equalToConstant: 70),
            companyLabels.heightAnchor.constraint(equalToConstant: 70),
            roleLabels.heightAnchor.constraint(equalToConstant: 70),
            teamLabels.heightAnchor.constraint(equalToConstant: 70),
            locationLabels.heightAnchor.constraint(equalToConstant: 70),
            linkLabels.heightAnchor.constraint(equalToConstant: 70),
            notesLabels.heightAnchor.constraint(equalToConstant: 70),
            appliedDateLabels.heightAnchor.constraint(equalToConstant: 70),
            lastUpdatedLabels.heightAnchor.constraint(equalToConstant: 70),
            
            deleteButton.topAnchor.constraint(equalTo: lastUpdatedLabels.bottomAnchor, constant: 50),
            deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
        ])
    }

}
