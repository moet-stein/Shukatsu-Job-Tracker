//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class AddEditViewController: UIViewController {
    
    private var selectedStatus: EditStatusButton!
    private var appliedDate: String = ""
    
    private var contentView: AddEditView!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = AddEditView()
        view = contentView
        
        editOpenButton = contentView.editOpenButton.statusButton
        editInterviewButton = contentView.editInterviewButton.statusButton
        editAppliedButton = contentView.editAppliedButton.statusButton
        editClosedButton = contentView.editClosedButton.statusButton
        
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
        
        addStatusBtnsTarget()
        addSaveBtnTarget()
        addDatePickerTarget()
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        appliedDate = dateFormatter.string(from: Date())
        
    }
    
    private func addStatusBtnsTarget() {
        editOpenButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editInterviewButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editAppliedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editClosedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
    }
    
    private func addSaveBtnTarget() {
        saveButton.addTarget(self, action: #selector(saveJob), for: .touchUpInside)
    }
    
    private func addDatePickerTarget() {
        appliedDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
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
    
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        appliedDate = dateFormatter.string(from: sender.date)
        print(appliedDate)
    }
    
    @objc func saveJob(sender: UIButton) {
        let companyName = companyField.textField.text ?? ""
        if companyName.isEmpty {
            print("emptyyy")
            return
        }

        let appliedDateString = appliedDate
        if appliedDate.isEmpty {
            print("emptyy applieddate")
            return
        }
        
        let location = locationField.textField.text ?? nil
        let status = selectedStatus.status
        let favorite = false
        let role = roleField.textField.text ?? nil
        let team = teamField.textField.text ?? nil
        let link = linkField.textField.text ?? nil
        let notes = notesField.textField.text ?? nil
        let updatedDate = Date()
        let newJob = Job(companyName: companyName, location: location, status: status, favorite: favorite, role: role, team: team, link: link, notes: notes, appliedDateString: appliedDateString, lastUpdate: updatedDate)

        print(appliedDate)
        dismiss(animated: true)
    }

}
