//
//  JobDetailsViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit



class JobDetailsViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var addJobInfoDelegate: AddJobInfoToHomeVC?
    
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
        
        
        print(selectedJob)
        setContent()
        addLinkTarget()
        addButtonsTarget()
    }
    
    init(selectedJob: JobInfo, addJobInfoDelegate: AddJobInfoToHomeVC?) {
        self.selectedJob = selectedJob
        self.addJobInfoDelegate = addJobInfoDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLinkTarget() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        linkLabels.linkTextView.addGestureRecognizer(tapRecognizer)
    }
    
    private func addButtonsTarget() {
        detailViewEditButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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
            self?.present(AddEditViewController(fromDetailsView: true, passedJob: self?.selectedJob, addJobInfoDelegate: HomeViewController()), animated: true, completion: nil)
        }
    }
    
    @objc func favoriteButtonTapped() {
        favoriteButton.showAnimation { [weak self] in
            self?.favoriteButton.isSelected.toggle()
            self?.toggleFavoriteBtn(updateInfo: true)
            
        }
        
    }
    
    private func setContent() {
        print(selectedJob)
        statusLabels.addStatusColor(status: selectedJob.status ?? "open")
        companyLabels.contentLabel.text = selectedJob.companyName
        roleLabels.contentLabel.text = selectedJob.role ?? " - "
        teamLabels.contentLabel.text = selectedJob.team ?? " - "
        locationLabels.contentLabel.text = selectedJob.location
        linkLabels.addLink(link: selectedJob.link)
        notesLabels.contentLabel.text = selectedJob.notes ?? " - "
        appliedDateLabels.contentLabel.text = selectedJob.appliedDateString ?? " - "
        lastUpdatedLabels.contentLabel.text = selectedJob.lastUpdateString
        favoriteButton.isSelected = selectedJob.favorite
        toggleFavoriteBtn(updateInfo: false)
        
    }
    
    private func toggleFavoriteBtn(updateInfo: Bool) {
        //UPDATE CORE DATA SELECTEDJOB.FAVORITE
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
        
        print(selectedJob.objectID)
        
        if updateInfo {
            selectedJob.favorite = favoriteButton.isSelected
            do {
               try context.save()
               addJobInfoDelegate?.updateJonInfoFavorite(jobInfo: selectedJob)
            } catch {
                print("Failed to save")
            }
            
        }
       
        
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
