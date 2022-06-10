//
//  AllFavFilterSectionView.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.06.22.
//

import UIKit

class AllFavFilterSectionView: UIView {
    lazy var viewAllButton: AllFavFilterButton = {
        let button = AllFavFilterButton(buttonText: "All", color: Colors.blueGrey, leftCorner: true, sfSymbol: "square.grid.2x2")
        button.isSelected = true
        button.tag = 1
        return button
    }()
    
    
    lazy var viewFavoritesButton: AllFavFilterButton = {
        let button = AllFavFilterButton(buttonText: "Favorites", color: Colors.viewOrange, leftCorner: false, sfSymbol: "heart")
        button.isSelected = false
        button.tag = 2
        return button
    }()

    init() {
        super.init(frame: .zero)
        
        setUpUI()
        viewAllButton.addTarget(self, action: #selector(allOrFavoritesButtonPressed), for: .touchUpInside)
        viewFavoritesButton.addTarget(self, action: #selector(allOrFavoritesButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(viewAllButton)
        addSubview(viewFavoritesButton)
        
        NSLayoutConstraint.activate([
            viewAllButton.topAnchor.constraint(equalTo: topAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 130),
            viewAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: topAnchor),
            viewFavoritesButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            viewFavoritesButton.widthAnchor.constraint(equalToConstant: 130),
            viewFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
        @objc func allOrFavoritesButtonPressed(sender: UIButton) {
            var viewAll: Bool = true
            if !sender.isSelected {
                sender.isSelected = !sender.isSelected
            }
            sender.setTitleColor(.white, for: .normal)
    
            if sender.tag == 1 {
                viewAll = true
                allOrFavoriteToggleColorWithAnimate(sender: sender, affectedBtn: viewFavoritesButton)
            } else {
                viewAll = false
                allOrFavoriteToggleColorWithAnimate(sender: sender, affectedBtn: viewAllButton)
            }
    
            NotificationCenter.default.post(name: NSNotification.Name("tappedAllOrFav"), object: nil, userInfo: ["viewAll": viewAll])
        }
        
        private func allOrFavoriteToggleColorWithAnimate(sender: UIButton, affectedBtn: AllFavFilterButton) {
            UIView.animate(withDuration: 0.4) {
                let tag1 : Bool = sender.tag == 1
                sender.backgroundColor = tag1 ? Colors.blueGrey : Colors.viewOrange
                sender.tintColor = .white
                affectedBtn.tintColor = tag1 ? Colors.viewOrange : Colors.blueGrey
                affectedBtn.setTitleColor(tag1 ? Colors.viewOrange : Colors.blueGrey, for: .normal)
                affectedBtn.backgroundColor = Colors.lightOrange
            }
        }
}
