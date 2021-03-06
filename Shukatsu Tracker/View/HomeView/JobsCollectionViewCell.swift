//
//  JobsCollectionViewCell.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 07.04.22.
//

import UIKit

class JobsCollectionViewCell: UICollectionViewCell {
    static let identifier = "JobsCollectionViewCell"
    
    var jobInfoViewModel: JobInfoViewModel! {
        didSet {
            companyNameLabel.text = jobInfoViewModel.companyName
            locationLabel.text = jobInfoViewModel.locationLabelText

            roundedView.backgroundColor = jobInfoViewModel.statusRoundedViewBgColor

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            dateTagLabel.text = "on \(dateFormatter.string(from: jobInfoViewModel.lastUpdate))"
        }
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = Colors.viewOrange
        return view
    }()
    
    private let dateTagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13
        view.backgroundColor = UIColor(white: 1, alpha: 0.7)
        return view
    }()
    
    private let dateTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoRegular, size: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoBold, size: 20)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.latoRegular, size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    private func setUpUI() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(dateTagView)
        dateTagView.addSubview(dateTagLabel)
        roundedView.addSubview(locationLabel)
        roundedView.addSubview(companyNameLabel)
        
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dateTagView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 10),
            dateTagView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -10),
            dateTagView.heightAnchor.constraint(equalToConstant: 26),
            dateTagView.widthAnchor.constraint(equalToConstant: 80),
            
            dateTagLabel.centerYAnchor.constraint(equalTo: dateTagView.centerYAnchor),
            dateTagLabel.centerXAnchor.constraint(equalTo: dateTagView.centerXAnchor),

            
            locationLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 15),
            locationLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -15),
            locationLabel.widthAnchor.constraint(equalToConstant: 100),
            locationLabel.heightAnchor.constraint(equalToConstant: 15),
            
            companyNameLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            companyNameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -5),
            companyNameLabel.widthAnchor.constraint(equalToConstant: 100),
            companyNameLabel.heightAnchor.constraint(equalToConstant: 22)
        
        ])
    }
    
    func animateCollectionView(cell: UICollectionViewCell) {
        cell.alpha = 0
        let animationDuration: Double = 1.0
        let delayBase: Double = 0.3
        
        let column = Double(cell.frame.minX / cell.frame.width)
        let row = Double(cell.frame.minY / cell.frame.height)

        let distance = sqrt(pow(column, 2) + pow(row, 2))
        let delay = sqrt(distance) * delayBase
        UIView.animate(withDuration: animationDuration, delay: delay, options: [], animations: {
            cell.alpha = 1.0
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
