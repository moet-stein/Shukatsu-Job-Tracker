//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit
import CoreData

protocol AddJobInfoToHomeVC: AnyObject {
    func addNewJobInfo(jobInfo: JobInfo)
    func updateJonInfoFavorite(jobInfo: JobInfo)
    func updateJobInfo(jobInfo: JobInfo)
}

protocol UpdateJobInfoInDetailsVC: AnyObject {
    func updateJobInfo(jobInfo: JobInfo)
}

class AddEditViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var addJobInfoDelegate: AddJobInfoToHomeVC?
    weak var updateJobInfoInDetailsVCDelegate: UpdateJobInfoInDetailsVC?
    
    private var fromDetailsView: Bool
    private var passedJob: JobInfo?
    
    private var selectedStatus: EditStatusButton!
    
    private var homeView: HomeView!
    private var jobsCollectionView: UICollectionView!
    
    private var contentView: AddEditView!
    
    private var titleLabel: UILabel!
    
    private var editOpenButton: EditStatusButton!
    private var editAppliedButton: EditStatusButton!
    private var editInterviewButton: EditStatusButton!
    private var editClosedButton: EditStatusButton!
    
    private var companyField: LabelAndTextField!
    private var locationField: LabelAndTextField!
    private var roleField: LabelAndTextField!
    private var teamField: LabelAndTextField!
    private var linkField: LabelAndTextField!
    private var notesField: LabelAndTextField!
    private var appliedDatePicker: UIDatePicker!
    private var appliedDateStackView: UIStackView!
    
    private var saveButton: UIButton!
    private var bottomSaveButton: UIButton!
    
    init(fromDetailsView: Bool, passedJob: JobInfo?, addJobInfoDelegate: AddJobInfoToHomeVC?, updateJobInfoInDetailsVCDelegate: UpdateJobInfoInDetailsVC?) {
        self.fromDetailsView = fromDetailsView
        self.passedJob = passedJob
        self.addJobInfoDelegate = addJobInfoDelegate
        self.updateJobInfoInDetailsVCDelegate = updateJobInfoInDetailsVCDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = AddEditView()
        view = contentView
        
        editOpenButton = contentView.editOpenButton.statusButton
        editInterviewButton = contentView.editInterviewButton.statusButton
        editAppliedButton = contentView.editAppliedButton.statusButton
        editClosedButton = contentView.editClosedButton.statusButton
        
        titleLabel = contentView.titleLabel
        
        companyField = contentView.companyField
        locationField = contentView.locationField
        roleField = contentView.roleField
        teamField = contentView.teamField
        linkField = contentView.linkField
        notesField = contentView.notesField
        appliedDatePicker = contentView.appliedDatePicker
        appliedDateStackView = contentView.appliedDateStackView
        
        saveButton = contentView.saveJobButton
        bottomSaveButton = contentView.bottomSaveButton
        
        setContent()
        addStatusBtnsTarget()
        addSaveBtnTarget()
        
        self.dismissKeyboard()
        
    }
    
    private func addStatusBtnsTarget() {
        editOpenButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editInterviewButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editAppliedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editClosedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
    }
    
    private func addSaveBtnTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        bottomSaveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    
    private func setContent() {
        titleLabel.text = fromDetailsView ? "Edit job details" : "Add a new job"
        if let job = passedJob {
            companyField.textField.text = job.companyName
            roleField.textField.text = job.role
            teamField.textField.text = job.team
            locationField.textField.text = job.location
            linkField.textField.text = job.link
            notesField.textField.text = job.notes
            
            switch job.status {
            case "open":
                selectedStatus = editOpenButton
            case "applied":
                selectedStatus = editAppliedButton
            case "interview":
                selectedStatus = editInterviewButton
            case "closed":
                selectedStatus = editClosedButton
            default:
                selectedStatus = editOpenButton
            }
            selectedStatus.isSelected = true
            selectedStatus.addRemoveCheckSymbol()
        } else {
            selectedStatus = editOpenButton
            selectedStatus.addRemoveCheckSymbol()
        }
        
        
        toggleAppliedDataStackView()
    }
    
    @objc func statusButtonPressed(sender: UIButton) {
        let button = sender as! EditStatusButton
        
        if selectedStatus != sender {
            selectedStatus.isSelected = false
            selectedStatus.addRemoveCheckSymbol()
            
            selectedStatus = button
            button.isSelected = true
            button.addRemoveCheckSymbol()
        }
        toggleAppliedDataStackView()
    }

    private func toggleAppliedDataStackView() {
        if selectedStatus.status != "open" {
            appliedDateStackView.isHidden = false
        } else {
            appliedDateStackView.isHidden = true
        }
    }

    
    @objc func saveButtonPressed(sender: UIButton) {
        let companyName = companyField.textField.text ?? ""
        if companyName.isEmpty {
            print("emptyyy")
            return
        }

        let appliedDate: Date?
        if appliedDateStackView.isHidden {
            appliedDate = nil
        } else {
            appliedDate = appliedDatePicker.date
        }
        
        let location = locationField.textField.text ?? nil
        let status = selectedStatus.status
        let favorite = false
        let role = roleField.textField.text ?? nil
        let team = teamField.textField.text ?? nil
        let link = linkField.textField.text ?? nil
        let notes = notesField.textField.text ?? nil

        saveJob(companyName: companyName, location: location, status: status, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDate: appliedDate, lastUpdate: Date())
        
    }
    
    private func saveJob(companyName: String, location: String?, status: String, favorite: Bool, role: String?, team: String?, link: String?, notes: String?, appliedDate: Date?, lastUpdate: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd, EEE"
        
        if let job = passedJob {
            //updateJobInfo don't forget to dismiss the view after calling the function
            job.companyName = companyName
            job.location = location
            job.status = status
            job.role = role
            job.team = team
            job.link = link
            job.notes = notes
            
            if let appliedDate = appliedDate {
                let dateString = formatter.string(from: appliedDate)
                job.appliedDateString = dateString
            }
            
            let lastUpdateString = formatter.string(from: lastUpdate)
            job.lastUpdateString = lastUpdateString
            
            do {
                try context.save()
                // FIX HERE TO SHOW UPDATED JOBDETAILS IN JOBDETAILSCONTROLLER AND HOMEVIEW??
                updateJobInfoInDetailsVCDelegate?.updateJobInfo(jobInfo: job)
//                addJobInfoDelegate?.updateJobInfo(jobInfo: job)
                dismiss(animated: true)
                
            } catch let error as NSError {
                print("Could not update. \(error), \(error.userInfo)")
            }
            
        } else {
            //createToDoListItem don't forget to dismiss the view after calling the function
            let entity = NSEntityDescription.entity(forEntityName: "JobInfo", in: context)!
            let jobInfo = NSManagedObject(entity: entity, insertInto: context)
            
            jobInfo.setValue(companyName, forKey: "companyName")
            jobInfo.setValue(location, forKey: "location")
            jobInfo.setValue(status, forKey: "status")
            jobInfo.setValue(favorite, forKey: "favorite")
            jobInfo.setValue(role, forKey: "role")
            jobInfo.setValue(team, forKey: "team")
            jobInfo.setValue(link, forKey: "link")
            jobInfo.setValue(notes, forKey: "notes")
            jobInfo.setValue(appliedDate, forKey: "appliedDate")
            jobInfo.setValue(lastUpdate, forKey: "lastUpdate")
            
            
            if let appliedDate = appliedDate {
                let dateString = formatter.string(from: appliedDate)
                jobInfo.setValue(dateString, forKey: "appliedDateString")
            }
            
            let lastUpdateString = formatter.string(from: lastUpdate)
            jobInfo.setValue(lastUpdateString, forKey: "lastUpdateString")
            
            do {
                try context.save()
                addJobInfoDelegate?.addNewJobInfo(jobInfo: jobInfo as! JobInfo)
                dismiss(animated: true)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    }

}


extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}


