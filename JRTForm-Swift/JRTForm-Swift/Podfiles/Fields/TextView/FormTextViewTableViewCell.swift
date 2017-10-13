//
//  FormTextViewTableViewCell.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/12/17.
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

class FormTextViewTableViewCell: BaseCell {
    
    // MARK: - Outlets
    @IBOutlet var label: UILabel!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    // MARK: - Properties
    override public var name: String {
        set {
            placeholderLabel.text = newValue
            label.text = newValue
        }
        
        get {
            return placeholderLabel.text ?? ""
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
            textView.text = newValue
            updateStyle()
        }
        
        get {
            return textView.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
    
    public var placeholderColor: UIColor? {
        set {
            placeholderLabel.textColor = newValue
        }
        
        get {
            return placeholderLabel.textColor
        }
    }
    
    public var isSecureTextEntry: Bool {
        set {
            textView.isSecureTextEntry = newValue
        }
        
        get {
            return textView.isSecureTextEntry
        }
    }
    
    // MARK: - Keyboard properties
    public var keyboardType: UIKeyboardType {
        set {
            textView.keyboardType = newValue
        }
        
        get {
            return textView.keyboardType
        }
    }
    
    public var returnKeyType: UIReturnKeyType {
        set {
            textView.returnKeyType = newValue
        }
        
        get {
            return textView.returnKeyType
        }
    }
    
    private var labelColor: UIColor?
    private var hideableLabel: Bool = false
    
    // MARK: - Action blocks
    public var errorMessageInValidationBlock: ((String) -> String)?
    public var didEndEditing: ((UITextView) -> Void)?
    public var didBeginEditing: ((UITextView) -> Void)?
    public var didChange: ((UITextView) -> Void)?
    public var didChangeSelection: ((UITextView) -> Void)?
    public var shouldBeginEditing: ((UITextView) -> Bool)?
    public var shouldEndEditing: ((UITextView) -> Bool)?
    public var shouldChangeCharacters: ((UITextView, NSRange, String) -> Bool)?
    public var shouldInteractWithURL: ((UITextView, URL, NSRange, UITextItemInteraction) -> Bool)?
    public var shouldInteractWithTextAttachment: ((UITextView, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
    
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
        placeholderLabel.isHidden = true
        if hideableLabel {
            label.isHidden = false
        }
    }
    
    public func setEmptyStyle() {
        if let _labelColor = labelColor {
            label.textColor = _labelColor
        }
        label.text = name
        placeholderLabel.isHidden = false
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
        textView.text = cellText
        if !isValid {
            setErrorStyleWith(message: errorMessageInValidationBlock!(cellText ?? ""))
        } else if !(cellText?.isEmpty ?? true) {
            setDefaultStyle()
        } else {
            setEmptyStyle()
        }
    }
    
    public func fieldBecomeFirstResponder() {
        textView.becomeFirstResponder()
    }
}

extension FormTextViewTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        updateStyle()
        didEndEditing?(textView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        didBeginEditing?(textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let _text = textView.text, _text.count == 0 {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        didChange?(textView)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        didChangeSelection?(textView)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return shouldEndEditing?(textView) ?? true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return shouldBeginEditing?(textView) ?? true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let swiftRange = Range<Int>(range), let textViewText = textView.text {
            if (swiftRange == Range(0..<0)) && (text.count == 1) && (textViewText.count == 0) {
                setDefaultStyle()
            } else if (swiftRange == Range(0..<textViewText.count)) && text.count == 0 {
                setEmptyStyle()
            }
        }
        return shouldChangeCharacters?(textView, range, text) ?? true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return shouldInteractWithURL?(textView, URL, characterRange, interaction) ?? true
     }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return shouldInteractWithTextAttachment?(textView, textAttachment, characterRange, interaction) ?? true
    }
    
}
