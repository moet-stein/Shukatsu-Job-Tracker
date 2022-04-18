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
    private var detailViewEditButton: UIButton!
    
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
        
        detailViewEditButton = contentView.detailViewEditButton
        
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
        addLinkTarget()
        addDetailViewEditButtonTarget()
    }
    
    init(selectedJob: Job) {
        self.selectedJob = selectedJob
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLinkTarget() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        linkLabels.linkTextView.addGestureRecognizer(tapRecognizer)
    }
    
    private func addDetailViewEditButtonTarget() {
        detailViewEditButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func linkTapped() {
        if let link = selectedJob.link {
            guard let url = URL(string: link) else {return}
            let vc = WebKitViewController(url: url)
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        }
    }
    
    @objc func editButtonTapped() {
        detailViewEditButton.showAnimation {
            print("editButtonTapped")
        }
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


public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
