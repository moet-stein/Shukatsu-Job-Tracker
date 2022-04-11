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
        view.backgroundColor = UIColor(named: "bgOffwhite")
        return view
    }()
    
    let saveJobButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Regular", size: 20)
        button.setTitleColor(UIColor(named: "viewOrange"), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(saveJobButton)
        
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200),

            saveJobButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            saveJobButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            saveJobButton.heightAnchor.constraint(equalToConstant: 50),
            saveJobButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        
    }
}
