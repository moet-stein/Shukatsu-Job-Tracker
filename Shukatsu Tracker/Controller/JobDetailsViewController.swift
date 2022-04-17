//
//  JobDetailsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class JobDetailsViewController: UIViewController {
    private var selectedJob: Job

    private var contentView: JobDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = JobDetailsView(selectedJob: selectedJob)
        view = contentView
        print(selectedJob)
    }
    
    init(selectedJob: Job) {
        self.selectedJob = selectedJob
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
