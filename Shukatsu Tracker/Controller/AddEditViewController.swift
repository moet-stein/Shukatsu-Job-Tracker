//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit
import CoreData

protocol HomeVCDelegate: AnyObject {
    func fetchJobInfosAndReload()
    func updateJonInfoFavorite(jobInfo: JobInfoViewModel)
    func updateProfileSettings()
}

protocol DetailsVCDelegate: AnyObject {
    func updateJobInfoInDetailsVC(jobInfo: JobInfoViewModel)
}

class AddEditViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var coreDataStack = CoreDataStack()
    private lazy var jobInfoDataManager = JobInfoDataManager(managedObjectContext: coreDataStack.mainContext,
                                                coreDataStack: coreDataStack)
    weak var editJobInHomeVCDelegate: HomeVCDelegate?
    weak var updateJobInfoInDetailsVCDelegate: DetailsVCDelegate?
    
    var currentTextField: String?
    
    private var fromDetailsView: Bool
    private var passedJob: JobInfoViewModel?
    
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
    private var cancelButton: CancelButton!
    private var bottomSaveButton: UIButton!
    
    let adjustNum: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 30
            case .pad:
                return 10
            default:
            return 0
        }
    }()
    
    
    
    init(fromDetailsView: Bool, passedJob: JobInfoViewModel?, addJobInfoDelegate: HomeVCDelegate?, updateJobInfoInDetailsVCDelegate: DetailsVCDelegate?) {
        self.fromDetailsView = fromDetailsView
        self.passedJob = passedJob
        self.editJobInHomeVCDelegate = addJobInfoDelegate
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
        cancelButton = contentView.cancelButton
        bottomSaveButton = contentView.bottomSaveButton
        
        setContent()
        addStatusBtnsTarget()
        addBtnsTarget()
        
        self.dismissKeyboard()
        
        addNotificationCenter()
        
    }

    
    private func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height - adjustNum
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y += keyboardSize.height - adjustNum
                }
            }
        }
    }
    
    private func addStatusBtnsTarget() {
        editOpenButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editInterviewButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editAppliedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editClosedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
    }
    
    private func addBtnsTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        bottomSaveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
    
    private func setContent() {
        contentView.setTitle(fromDetailsView: fromDetailsView)
        
        if let job = passedJob {
            contentView.setContentFromData(job: job)
            
            let jobStatus = JobStatus(rawValue: job.status)
            switch jobStatus {
            case .open:
                selectedStatus = editOpenButton
            case .applied:
                selectedStatus = editAppliedButton
            case .interview:
                selectedStatus = editInterviewButton
            case .closed:
                selectedStatus = editClosedButton
            case .none:
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
        if selectedStatus.status != JobStatus.open {
            appliedDateStackView.isHidden = false
        } else {
            appliedDateStackView.isHidden = true
        }
    }

    
    @objc func saveButtonPressed(sender: UIButton, gestureRecognizer: UITapGestureRecognizer) {
        saveButton.handleTapShortDuration(gestureRecognizer: gestureRecognizer)
        
        do {
            try saveJob()
        } catch SaveError.companyNameLocationEmpty {
            showAlert(alertText: "Company name & location fields are required")
        } catch SaveError.companyNameEmpty {
            showAlert(alertText: "Company name field is required")
        } catch SaveError.locationEmpty {
            showAlert(alertText: "Location fields is required")
        } catch {
            showAlert(alertText: "Unable to Save")
        }

    }
    
    private func saveJob() throws {
        let companyName = companyField.textField.text!
        let location = locationField.textField.text!
        
        if companyName.isEmpty && location.isEmpty {
            throw SaveError.companyNameLocationEmpty
        }
        
        if companyName.isEmpty {
            throw SaveError.companyNameEmpty
        }
        
        if location.isEmpty {
            throw SaveError.locationEmpty
        }
        
        let appliedDate: Date?
        if appliedDateStackView.isHidden {
            appliedDate = nil
        } else {
            appliedDate = appliedDatePicker.date
        }
        

        let status = selectedStatus.status
        let favorite = false
        let role = roleField.textField.text ?? nil
        let team = teamField.textField.text ?? nil
        let link = linkField.textField.text ?? nil
        let notes = notesField.textField.text ?? nil

        if let passedJob = passedJob {
            jobInfoDataManager.updateJobInfo(detailsVCdelegate: updateJobInfoInDetailsVCDelegate, job: passedJob.jobInfo, companyName: companyName, location: location, status: status.rawValue, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDate: appliedDate, lastUpdate: Date())
            dismiss(animated: true)
        } else {
            jobInfoDataManager.createJobInfo(delegate: editJobInHomeVCDelegate, companyName: companyName, location: location, status: status.rawValue, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDate: appliedDate, lastUpdate: Date())
            dismiss(animated: true)
        }
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(alertText: String) {
        let alert = UIAlertController(title: "", message: alertText, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
          alert.dismiss(animated: true, completion: nil)
        }
    }

}

