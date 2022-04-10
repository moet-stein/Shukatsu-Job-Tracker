//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class AddEditViewController: UIViewController {
    
    private var contentView: AddEditView!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = AddEditView()
        view = contentView
    }

}
