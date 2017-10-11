//
//  FormViewController.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

private struct FieldIdentifiers {
    static let text = "textField"
    static let secureText = "secureTextField"
    static let textView = "textView"
    static let phoneNumber = "phoneNumberField"
    static let selectOption = "selectOptionField"
    static let selectMultipleOptions = "multipleOptionField"
    static let `switch` = "switchField"
    static let date = "dateField"
    static let map = "mapField"
}

class FormViewController: UIViewController {

    @IBOutlet private weak var tableView: FormTableView!
    
    // MARK: - Table view cell iVars
    lazy var textField: FormTextFieldTableViewCell = {
        let _textField = tableView.formCellOf(type: .textField, andName: FieldIdentifiers.text) as? FormTextFieldTableViewCell ?? FormTextFieldTableViewCell()
        _textField.placeholderColor = .gray
        _textField.returnKeyType = .next
        _textField.shouldReturn = { textField in
            // TODO: - Focus next textfield when pressing "Enter"
            return true
        }
        _textField.errorMessageInValidationBlock = { stringToValidate in
            do {
                
            }
            return ""
        }
        return tableView.formCellOf(type: .textField, andName: FieldIdentifiers.text) as? FormTextFieldTableViewCell ?? FormTextFieldTableViewCell()
    }()
    
    lazy var secureTextField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Secure TextField"
        return cell
    }()
    
    lazy var textView: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "TextView"
        return cell
    }()
    
    lazy var phoneNumberField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Phone Number"
        return cell
    }()
    
    lazy var selectOptionField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Select Option"
        return cell
    }()
    
    lazy var selectMultipleOptionField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Multiple Option"
        return cell
    }()
    
    lazy var switchField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Switch"
        return cell
    }()
    
    lazy var dateField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Date"
        return cell
    }()
    
    lazy var mapField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Map"
        return cell
    }()
    
    lazy var submitButton: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Submit"
        return cell
    }()
    
    lazy var customTextField: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Custom"
        return cell
    }()
    
    lazy var stringValidator: StringValidationHelper = {
        return StringValidationHelper()
    }()
    
    lazy var arrayValidator: ArrayValidationHelper = {
        return ArrayValidationHelper()
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Form"
    }
}

extension FormViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 9 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    return textField
                case 1:
                    return secureTextField
                case 2:
                    return textView
                case 3:
                    return phoneNumberField
                case 4:
                    return selectOptionField
                case 5:
                    return selectMultipleOptionField
                case 6:
                    return switchField
                case 7:
                    return dateField
                case 8:
                    return mapField
                case 9:
                    return submitButton
                default:
                    return UITableViewCell()
            }
            case 1:
                return customTextField
            default:
            return UITableViewCell()
        }
    }
}
