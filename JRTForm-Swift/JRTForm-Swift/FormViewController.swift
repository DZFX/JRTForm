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
    static let secureText = "textField"
    static let textView = "textField"
    static let phoneNumber = "textField"
    static let selectOption = "textField"
    static let selectMultipleOptions = "textField"
    static let `switch` = "textField"
    static let date = "textField"
    static let map = "textField"
}

class FormViewController: UITableViewController {

    // MARK: - Table view cell iVars
    lazy var textField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var secureTextField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var textView: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var phoneNumberField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var selectOptionField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var selectMultipleOptionField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var switchField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var dateField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var mapField: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var submitButton: UITableViewCell = {
        return UITableViewCell()
    }()
    
    lazy var customTextField: UITableViewCell = {
        return UITableViewCell()
    }
    
    lazy var stringValidator: NSObject = {
        return NSObject()
    }
    
    lazy var arrayValidator: NSObject = {
        return NSObject()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Form"
    }
}
