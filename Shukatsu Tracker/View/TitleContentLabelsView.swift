//
//  TitleContentLabelsView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 17.04.22.
//

import UIKit

class TitleContentLabelsView: UIView {

    var titleText: String
    var boldText: Bool
    
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
        label.font = UIFont(name: Fonts.latoRegular, size: 20)
        label.textColor = Colors.softBrown
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    
    init(titleText: String, boldText: Bool, frame: CGRect = .zero) {
        self.titleText = titleText
        self.boldText = boldText
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
        if boldText {
            contentLabel.font = UIFont(name: Fonts.latoBold, size: 26)
        } else {
            contentLabel.font = UIFont(name: Fonts.latoLight, size: 18)
        }
        titleLabel.text = titleText
    }
    
    
    func addStatusColor(status: JobStatus) {
        let jobStatus = status
        contentLabel.setText(jobStatus.rawValue, prependedBySymbolNameed: "square.fill")
        
        switch jobStatus {
        case .open :
            contentLabel.textColor = Colors.skyBlue
        case .applied :
            contentLabel.textColor = Colors.lightGreen
        case .interview:
            contentLabel.textColor = Colors.viewOrange
        case .closed:
            contentLabel.textColor = Colors.blueGrey
        }
    }
    
}

extension UILabel {
    func setText(_ text: String, prependedBySymbolNameed symbolSystemName: String, font: UIFont? = nil) {
        if #available(iOS 13.0, *) {
            if let font = font { self.font = font }
            let symbolConfiguration = UIImage.SymbolConfiguration(font: self.font)
            let symbolImage = UIImage(systemName: symbolSystemName, withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
            let symbolTextAttachment = NSTextAttachment()
            symbolTextAttachment.image = symbolImage
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(attachment: symbolTextAttachment))
            attributedText.append(NSAttributedString(string: " " + text))
            self.attributedText = attributedText
        } else {
            self.text = text // fallback
        }
    }
}
