//
//  FormTableView.swift
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

public enum FormTableViewCellType {
    case textField
    case textView
    case custom(nibName: String)
    
    public var nibName: String {
        switch self {
        case .textField:
            return "FormTextFieldTableViewCell"
        case .textView:
            return "FormTextViewTableViewCell"
        case .custom(let nibName):
            return nibName
        }
    }
}

class FormTableView: UITableView {
    
    weak var assignedDelegate: UITableViewDelegate?
    
    override var delegate: UITableViewDelegate? {
        set {
            if (newValue as? FormTableView) == self {
                assignedDelegate = nil
            } else {
                assignedDelegate = newValue
            }
            super.delegate = newValue
        }
        
        get {
            return super.delegate
        }
    }
    
    // MARK: - Override
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if delegate == nil {
            delegate = self
        }
    }
    
    // MARK: - Public functions
    public func formCellOf(type: FormTableViewCellType, andName name: String) -> BaseCell {
        return formFieldCellWith(nibName: type.nibName, andNameIdentifier: name)
    }

    private func formFieldCellWith(nibName: String, andNameIdentifier name: String) -> BaseCell {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: name)
        if let cell = dequeueReusableCell(withIdentifier: name) as? BaseCell {
            cell.name = name
            return cell
        }
        return BaseCell()
    }
}

// MARK: - UITableViewDelegate
extension FormTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.assignedDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}
