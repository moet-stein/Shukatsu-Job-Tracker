//
//  HomeView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class HomeView: UIView {

    private let testLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Second View"
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemOrange
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: topAnchor),
            testLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            testLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
