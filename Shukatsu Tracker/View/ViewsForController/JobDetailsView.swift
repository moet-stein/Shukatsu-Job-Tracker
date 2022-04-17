//
//  JobDetailsView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class JobDetailsView: UIView {
    
    private var selectedJob: Job

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
    

    
    init(selectedJob: Job) {
        self.selectedJob = selectedJob
        super.init(frame: .zero)
        
        setUpUI()
        fillJobInfo()
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
            buttonsHStackView.widthAnchor.constraint(equalToConstant: 130)
            
        ])
    }
    
    
    private func fillJobInfo() {
        
    }

}
