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
    
    private var statusLabels: TitleContentLabelsView!
    private var companyLabels: TitleContentLabelsView!
    private var roleLabels: TitleContentLabelsView!
    private var teamLabels: TitleContentLabelsView!
    private var locationLabels: TitleContentLabelsView!
    private var linkLabels: TitleLinkView!
    private var notesLabels: TitleContentLabelsView!
    private var appliedDateLabels: TitleContentLabelsView!
    private var lastUpdatedLabels: TitleContentLabelsView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = JobDetailsView(selectedJob: selectedJob)
        view = contentView
        
        statusLabels = contentView.statusLabels
        companyLabels = contentView.companyLabels
        roleLabels = contentView.roleLabels
        teamLabels = contentView.teamLabels
        locationLabels = contentView.locationLabels
        linkLabels = contentView.linkLabels
        notesLabels = contentView.notesLabels
        appliedDateLabels = contentView.appliedDateLabels
        lastUpdatedLabels = contentView.lastUpdatedLabels
        
        
        print(selectedJob)
        setContentLabels()
    }
    
    init(selectedJob: Job) {
        self.selectedJob = selectedJob
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentLabels() {
        statusLabels.addStatusColor(status: selectedJob.status)
        companyLabels.contentLabel.text = selectedJob.companyName
        roleLabels.contentLabel.text = selectedJob.role ?? " - "
        teamLabels.contentLabel.text = selectedJob.team ?? " - "
        locationLabels.contentLabel.text = selectedJob.location
        linkLabels.addLink(link: selectedJob.link)
        notesLabels.contentLabel.text = selectedJob.notes ?? " - "
        appliedDateLabels.contentLabel.text = selectedJob.appliedDateString ?? " - "
        lastUpdatedLabels.contentLabel.text = selectedJob.lastUpdateString
        
    }
    
}
