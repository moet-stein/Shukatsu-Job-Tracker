//
//  SetProfileNameViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 26.04.22.
//

import UIKit

class SetProfileNameViewController: UIViewController {
    
    private let textEditTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(EditProfileViewCell.self, forCellReuseIdentifier: EditProfileViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lightOrange")
        textEditTableView.dataSource = self
        textEditTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    


}

extension SetProfileNameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        return cell
    }
    
    
}

extension SetProfileNameViewController: UITableViewDelegate {
    
}

//class EditProfileViewCell: UITableViewCell {
//    static let identifier = "EditProfileViewCell"
//
//    private let editableTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .clear
//        textField.tintColor = .orange
//        return textField
//    }()
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setUpUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setUpUI() {
//        addSubview(editableTextField)
//
//        NSLayoutConstraint.activate([
//            editableTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            editableTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            editableTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            editableTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
//        ])
//    }
//
//
////    func setupCellContent(titleString: String) {
////        titleLabel.text = titleString
////    }
//
//}
