//
//  FormTextFieldTableViewCell.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/5/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

fileprivate let kFormTextFieldTableViewCell = "FormTextFieldTableViewCell"

class FormTextFieldTableViewCell: BaseCell, CellValidatable {

    
    // MARK: - Outlets
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Properties
    public var name: String = ""
    public var isValid: Bool = false
    
    private var labelColor: UIColor?
    private var hideableLabel: Bool = false
    
    // MARK: - Keyboard properties
    public var keyboardType: UIKeyboardType {
        set {
            textField.keyboardType = newValue
        }
        
        get {
            return textField.keyboardType
        }
    }
    
    public var returnKeyType: UIReturnKeyType {
        set {
            textField.returnKeyType = newValue
        }
        
        get {
            return textField.returnKeyType
        }
    }
    
    
    
    public var errorMessageInValidationBlock: ((String) -> String)?
    
    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        hideableLabel = label.isHidden
        labelColor = label.textColor
    }
    
    // MARK: - Public functions
    
    public func setDefaultStyle() {
        if let _labelColor = labelColor {
            label.textColor = _labelColor
        }
        label.text = name
    }
    
    func updateStyle() {
        
    }
    
    
}

extension FormTextFieldTableViewCell: UITextFieldDelegate {
    
}
