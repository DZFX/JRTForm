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
    public var cellText: String? {
        set {
            textField.text = newValue
            updateStyle()
        }
        
        get {
            return textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
    
    public var name: String = "" {
        didSet {
            textField.placeholder = name
            label.text = name
        }
    }
    public var isValid: Bool {
        var valid = true
        if let _errorMessageInValidationBlock = errorMessageInValidationBlock {
            let errorMessage = _errorMessageInValidationBlock(cellText)
            if !errorMessage.isEmpty {
                valid = false
            }
        }
        return valid
    }
    
    public var placeholderColor: UIColor? {
        set {
            if let _placeholder = textField.placeholder, let _newColor = newValue {
                textField.attributedPlaceholder = NSAttributedString(string: _placeholder, attributes: [NSAttributedStringKey.foregroundColor: _newColor])
            }
        }
        
        get {
            if let _placeholder = textField.attributedPlaceholder {
                var range = NSRange(location: 0, length: _placeholder.length)
                return textField.attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: &range) as? UIColor
            }
            return nil
        }
    }
    
    private var isSecureTextEntry: Bool {
        set {
            textField.isSecureTextEntry = newValue
        }
        
        get {
            return textField.isSecureTextEntry
        }
    }
    
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
    
    private var labelColor: UIColor?
    private var hideableLabel: Bool = false
    
    // MARK: - Action blocks
    public var errorMessageInValidationBlock: ((String?) -> String)?
    public var didEndEditing: ((UITextField) -> Void)?
    public var didBeginEditing: ((UITextField) -> Void)?
    public var shouldBeginEditing: ((UITextField) -> Bool)?
    public var shouldEndEditing: ((UITextField) -> Bool)?
    public var shouldClear: ((UITextField) -> Bool)?
    public var shouldReturn: ((UITextField) -> Bool)?
    public var shouldChangeCharacters: ((UITextField, NSRange, String) -> Bool)?
    
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
        label.isHidden = !hideableLabel
    }
    
    public func setEmptyStyle() {
        if let _labelColor = labelColor {
            label.textColor = _labelColor
        }
        label.text = name
        label.isHidden = hideableLabel
    }
    
    public func setErrorStyleWith(message: String) {
        if labelColor != nil {
            label.textColor = .red
        }
        label.text = "\(name): \(message)"
        label.isHidden = !hideableLabel
    }
    
    public func updateStyle() {
        textField.text = cellText
        if !isValid {
            setErrorStyleWith(message: errorMessageInValidationBlock!(cellText))
        } else if !(cellText?.isEmpty ?? true) {
            setDefaultStyle()
        } else {
            setEmptyStyle()
        }
    }
    
    public func fieldBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
}

extension FormTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing?(textField)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return shouldClear?(textField) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldReturn?(textField) ?? true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return shouldEndEditing?(textField) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldBeginEditing?(textField) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldChangeCharacters?(textField, range, string) ?? true
    }
}