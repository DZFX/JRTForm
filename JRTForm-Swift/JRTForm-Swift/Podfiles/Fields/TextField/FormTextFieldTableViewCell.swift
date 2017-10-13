//
//  FormTextFieldTableViewCell.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/5/17.
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

fileprivate let kFormTextFieldTableViewCell = "FormTextFieldTableViewCell"

class FormTextFieldTableViewCell: BaseCell {
    
    // MARK: - Outlets
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    // MARK: - Properties
    override public var name: String {
        set {
            textField.placeholder = newValue
            label.text = newValue
        }
        
        get {
            return textField.placeholder ?? ""
        }
    }
    
    override public var isValid: Bool {
        var valid = true
        if let _errorMessageInValidationBlock = errorMessageInValidationBlock {
            let errorMessage = _errorMessageInValidationBlock(cellText ?? "")
            if !errorMessage.isEmpty {
                valid = false
            }
        }
        return valid
    }
    
    public var cellText: String? {
        set {
            textField.text = newValue
            updateStyle()
        }
        
        get {
            return textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        }
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
    
    public var isSecureTextEntry: Bool {
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
    public var errorMessageInValidationBlock: ((String) -> String)?
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
        if hideableLabel {
            label.isHidden = false
        }
    }
    
    public func setEmptyStyle() {
        if let _labelColor = labelColor {
            label.textColor = _labelColor
        }
        label.text = name
        if hideableLabel {
            label.isHidden = true
        }
    }
    
    public func setErrorStyleWith(message: String) {
        if labelColor != nil {
            label.textColor = .red
        }
        label.text = "\(name) \(message)"
        if hideableLabel {
            label.isHidden = false
        }
    }
    
    override public func updateStyle() {
        textField.text = cellText
        if !isValid {
            setErrorStyleWith(message: errorMessageInValidationBlock!(cellText ?? ""))
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
        updateStyle()
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
        if let swiftRange = Range<Int>(range), let textFieldText = textField.text {
            if (swiftRange == Range(0..<0)) && (string.count == 1) && (textFieldText.count == 0) {
                setDefaultStyle()
            } else if (swiftRange == Range(0..<textFieldText.count)) && string.count == 0 {
                setEmptyStyle()
            }
        }
        
        return shouldChangeCharacters?(textField, range, string) ?? true
    }
}
