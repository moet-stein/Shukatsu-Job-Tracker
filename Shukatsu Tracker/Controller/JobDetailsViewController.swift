//
//  JobDetailsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit


class JobDetailsViewController: UIViewController {
    deinit {
        print("JobDetailsViewController deinit")
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var jobEditedHomeVCDelegate: HomeVCDelegate?
    
    private var selectedJob: JobInfo

    private var contentView: JobDetailsView!
    private var detailViewEditButton: UIButton!
    private var favoriteButton: UIButton!
    
    private var statusLabels: TitleContentLabelsView!
    private var companyLabels: TitleContentLabelsView!
    private var roleLabels: TitleContentLabelsView!
    private var teamLabels: TitleContentLabelsView!
    private var locationLabels: TitleContentLabelsView!
    private var linkLabels: TitleLinkView!
    private var notesLabels: TitleContentLabelsView!
    private var appliedDateLabels: TitleContentLabelsView!
    private var lastUpdatedLabels: TitleContentLabelsView!
    
    private var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = JobDetailsView(selectedJob: selectedJob)
        view = contentView
        
        detailViewEditButton = contentView.detailViewEditButton
        favoriteButton = contentView.favoriteButton
        
        statusLabels = contentView.statusLabels
        companyLabels = contentView.companyLabels
        roleLabels = contentView.roleLabels
        teamLabels = contentView.teamLabels
        locationLabels = contentView.locationLabels
        linkLabels = contentView.linkLabels
        notesLabels = contentView.notesLabels
        appliedDateLabels = contentView.appliedDateLabels
        lastUpdatedLabels = contentView.lastUpdatedLabels
        
        deleteButton = contentView.deleteButton
        
        setContent(job: selectedJob)
        addLinkTarget()
        addButtonsTarget()
    }
    
    init(selectedJob: JobInfo, addJobInfoDelegate: HomeVCDelegate?) {
        self.selectedJob = selectedJob
        self.jobEditedHomeVCDelegate = addJobInfoDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        jobEditedHomeVCDelegate?.fetchJobInfosAndReload()
    }
    
    private func addLinkTarget() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        linkLabels.linkTextView.addGestureRecognizer(tapRecognizer)
    }
    
    private func addButtonsTarget() {
        detailViewEditButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
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
        detailViewEditButton.showAnimation { [weak self] in
            self?.present(AddEditViewController(
                fromDetailsView: true,
                passedJob: self?.selectedJob,
                addJobInfoDelegate: HomeViewController(),
                updateJobInfoInDetailsVCDelegate: self),
                          animated: true, completion: nil)
        }
    }
    
    @objc func favoriteButtonTapped() {
        favoriteButton.showAnimation { [weak self] in
            self?.favoriteButton.isSelected.toggle()
            self?.toggleFavoriteBtn(updateInfo: true)
        }
    }
    
    @objc func deleteButtonTapped() {
        print("BUtton tapped")
        let alertController = UIAlertController(title: "Do you want to delete this job?", message: "Select Cancel or Delete", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "DELETE", style: .destructive) { _ in
            JobInfoDataManager.deleteJobInfo(job: self.selectedJob)
            self.jobEditedHomeVCDelegate?.fetchJobInfosAndReload()
            self.dismiss(animated: true)
        })
        
        alertController.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func setContent(job: JobInfo) {
        statusLabels.addStatusColor(status: job.status ?? "open")
        companyLabels.contentLabel.text = job.companyName
        roleLabels.contentLabel.text = job.role ?? " - "
        teamLabels.contentLabel.text = job.team ?? " - "
        locationLabels.contentLabel.text = job.location
        linkLabels.addLink(link: job.link)
        notesLabels.contentLabel.text = job.notes ?? " - "
        appliedDateLabels.contentLabel.text = job.appliedDateString ?? " - "
        lastUpdatedLabels.contentLabel.text = job.lastUpdateString
        favoriteButton.isSelected = job.favorite
        toggleFavoriteBtn(updateInfo: false)
        
    }
    
    private func toggleFavoriteBtn(updateInfo: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        
        if favoriteButton.isSelected {
            let heartSF = UIImage(systemName: "heart.fill", withConfiguration: config)
            favoriteButton.setImage(heartSF, for: .selected)
            print("isselected")
        } else {
            let heartSF = UIImage(systemName: "heart", withConfiguration: config)
            favoriteButton.setImage(heartSF, for: .normal)
            print("isNOTselected")
        }
        
        
        if updateInfo {
            selectedJob.favorite = favoriteButton.isSelected
            do {
               try context.save()
               jobEditedHomeVCDelegate?.updateJonInfoFavorite(jobInfo: selectedJob)
            } catch {
                print("Failed to save")
            }
            
        }
    }
    
}

extension JobDetailsViewController: DetailsVCDelegate {
    func updateJobInfoInDetailsVC(jobInfo: JobInfo) {
        self.setContent(job: jobInfo)
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
