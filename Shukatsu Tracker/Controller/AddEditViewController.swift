//
//  AddEditViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 10.04.22.
//

import UIKit

class AddEditViewController: UIViewController {
    
    private var selectedStatus: EditStatusButton!
    
    private var contentView: AddEditView!
    
    private var editOpenButton: EditStatusButton!
    private var editAppliedButton: EditStatusButton!
    private var editInterviewButton: EditStatusButton!
    private var editClosedButton: EditStatusButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = AddEditView()
        view = contentView
        
        editOpenButton = contentView.editOpenButton.statusButton
        editInterviewButton = contentView.editInterviewButton.statusButton
        editAppliedButton = contentView.editAppliedButton.statusButton
        editClosedButton = contentView.editClosedButton.statusButton
        
        selectedStatus = editOpenButton
        selectedStatus.addRemoveCheckSymbol()
        addStatusBtnsTarget()
        
    }
    
    private func addStatusBtnsTarget() {
        editOpenButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editInterviewButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editAppliedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        editClosedButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
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

}

