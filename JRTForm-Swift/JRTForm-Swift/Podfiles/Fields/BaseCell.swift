//
//  BaseCell.swift
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

public class BaseCell: UITableViewCell {

    // MARK: - Properties
    open var name: String {
        set {
            assertionFailure("Should be implemented by subclass")
        }
        
        get {
            assertionFailure("Should be implemented by subclass")
            return ""
        }
    }
    open var isValid: Bool {
        get {
            assertionFailure("Should be implemented by subclass")
            return false
        }
    }
    public weak var superTableView: UITableView? {
        var currentView: UIView? = self
        while currentView != nil {
            if currentView is UITableView {
                break
            } else {
                currentView = currentView?.superview
            }
        }
        return currentView as? UITableView
    }
    
    // MARK: - Override functions
    public override func didMoveToSuperview() {
        guard superTableView is FormTableView else {
            print(#function)
            assertionFailure("TableView must be of type \(FormTableView.self)")
            return
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        assertionFailure("This cell should not be reused")
    }
    
    // MARK: - Instance functions
    open func updateStyle() {
        print(#function)
        assertionFailure("Should be implemented by the subclass")
    }
}
