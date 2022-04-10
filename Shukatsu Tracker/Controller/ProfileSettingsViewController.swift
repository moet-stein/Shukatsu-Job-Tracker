//
//  ProfileSettingsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class ProfileSettingsViewController: UIViewController {


    private var contentView: ProfileSettingsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = ProfileSettingsView()
        view = contentView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
