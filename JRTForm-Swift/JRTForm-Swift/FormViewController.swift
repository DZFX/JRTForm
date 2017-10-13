//
//  FormViewController.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

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
            self.secureTextField.fieldBecomeFirstResponder()
            textField.resignFirstResponder()
            // TODO: - Focus next textfield when pressing "Enter"
            return true
        }
        _textField.errorMessageInValidationBlock = { (stringToValidate) -> String in
            do {
                try self.stringValidator.required(stringToValidate)
                try self.stringValidator.alpha(stringToValidate)
                try self.stringValidator.maxLength(stringToValidate, 8)
                try self.stringValidator.minLength(stringToValidate, 3)
            } catch StringValidationError.required(let defaultMessage) {
                // Optionally take the default message
                return defaultMessage
            } catch StringValidationError.alpha {
                return "should be alphabetic characters"
            } catch StringValidationError.maxLength(let length) {
                // Or ignore and implement your own message with the provided info
                return "should be no more than \(length) characters"
            } catch StringValidationError.minLength(let length) {
                return "should be no less than \(length) characters"
            } catch {
                return "is invalid"
            }
            return ""
        }
        return _textField
    }()
    
    lazy var secureTextField: FormTextFieldTableViewCell = {
        let _textField = tableView.formCellOf(type: .textField, andName: FieldIdentifiers.secureText) as? FormTextFieldTableViewCell ?? FormTextFieldTableViewCell()
        _textField.placeholderColor = .gray
        _textField.returnKeyType = .next
        _textField.isSecureTextEntry = true
        _textField.shouldReturn = { textField in
            textField.resignFirstResponder()
            // TODO: - Focus next textfield when pressing "Enter"
            return true
        }
        _textField.errorMessageInValidationBlock = { (stringToValidate) -> String in
            do {
                try self.stringValidator.required(stringToValidate)
                try self.stringValidator.minLength(stringToValidate, 3)
            } catch StringValidationError.required {
                // catch error and use custom message
                return "is required"
            } catch StringValidationError.minLength(_, let defaultMessage) {
                // catch error and use default message
                return defaultMessage
            } catch {
                return "is invalid"
            }
            return ""
        }
        return _textField
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
