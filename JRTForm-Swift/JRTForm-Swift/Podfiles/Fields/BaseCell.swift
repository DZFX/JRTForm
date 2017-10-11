//
//  BaseCell.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/5/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

//protocol CellValidatable {
//    var name: String { get set }
//    var isValid: Bool { get }
//    func updateStyle()
//}

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
