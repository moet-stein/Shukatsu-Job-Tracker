//
//  JobDetailsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class JobDetailsViewController: UIViewController {

    private var contentView: JobDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = JobDetailsView()
        view = contentView
    }

}
