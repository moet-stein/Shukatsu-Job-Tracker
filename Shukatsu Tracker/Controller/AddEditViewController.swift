//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController {
    
    private var fromDetailsView: Bool
    private var passedJob: Job?
    
    private var selectedStatus: EditStatusButton!
//    private var appliedDate: String = ""
    
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
//    private var appliedDateField: LabelAndTextField!
    
    private var saveButton: UIButton!
    
    init(fromDetailsView: Bool, passedJob: Job?) {
        self.fromDetailsView = fromDetailsView
        self.passedJob = passedJob
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
        
        saveButton = contentView.saveJobButton
        
        selectedStatus = editOpenButton
        selectedStatus.addRemoveCheckSymbol()
        
        setContent()
        addStatusBtnsTarget()
        addSaveBtnTarget()
//        addDatePickerTarget()
        
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        appliedDate = dateFormatter.string(from: Date())
        
    }
    
    private func addStatusBtnsTarget() {
        editOpenButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editInterviewButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editAppliedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editClosedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
    }
    
    private func addSaveBtnTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
//    private func addDatePickerTarget() {
//        appliedDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
//    }
    
    private func setContent() {
        titleLabel.text = fromDetailsView ? "Edit job details" : "Add a new job"
        if let job = passedJob {
            companyField.textField.text = job.companyName
        }
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
    }
    
    
//    @objc func datePickerChanged(_ sender: UIDatePicker) {
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        appliedDate = dateFormatter.string(from: sender.date)
//        print(appliedDate)
//    }
    
    @objc func saveButtonPressed(sender: UIButton) {
        let companyName = companyField.textField.text ?? ""
        if companyName.isEmpty {
            print("emptyyy")
            return
        }

//        let appliedDateString = appliedDate
//        if appliedDate.isEmpty {
//            print("emptyy applieddate")
//            return
//        }
        let appliedDate = appliedDatePicker.date
        let location = locationField.textField.text ?? nil
        let status = selectedStatus.status
        let favorite = false
        let role = roleField.textField.text ?? nil
        let team = teamField.textField.text ?? nil
        let link = linkField.textField.text ?? nil
        let notes = notesField.textField.text ?? nil
        let updatedDate = Date()
//        let newJob = Job(companyName: companyName, location: location, status: status, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDateString: appliedDateString, lastUpdate: updatedDate)

        saveJob(companyName: companyName, location: location, status: status, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDate: appliedDate, lastUpdate: Date())
        dismiss(animated: true)
    }
    
    private func saveJob(companyName: String, location: String?, status: String, favorite: Bool, role: String?, team: String?, link: String?, notes: String?, appliedDate: Date, lastUpdate: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "JobInfo", in: managedContext)!
        
        let jobInfo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        jobInfo.setValue(companyName, forKey: "companyName")
        
        do {
            try managedContext.save()
            //            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
