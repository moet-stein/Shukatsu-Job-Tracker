//
//  TitleLinkView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 18.04.22.
//

import UIKit

class TitleLinkView: UIView {

    var titleText: String
    
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
        label.textColor = UIColor(named: "softBrown")
        return label
    }()
    
    let linkTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        
        textView.tintColor = UIColor(named: "softBrown")
        
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.backgroundColor = UIColor(named: "lightOrange")
        return textView
    }()
    
    
    
    
    init(titleText: String, frame: CGRect = .zero) {
        self.titleText = titleText
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
        vStackView.addArrangedSubview(linkTextView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            linkTextView.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func setContent(){
        titleLabel.text = titleText
    }
    
    
    func addLink(link: String?) {
        if let link = link {
            let attributedString = NSMutableAttributedString(string: link)
            let range = NSString(string: link).range(of: link)
            attributedString.addAttribute(NSAttributedString.Key.link, value: link, range: range)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
            linkTextView.attributedText = attributedString
            linkTextView.font = UIFont(name: "Lato-Regular", size: 17)
        } else {
            linkTextView.text = " - "
        }
    }
    

}
