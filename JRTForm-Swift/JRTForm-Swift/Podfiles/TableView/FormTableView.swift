//
//  FormTableView.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/5/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

public enum FormTableViewCellType {
    case textField
    case custom(nibName: String)
    
    public var nibName: String {
        switch self {
        case .textField:
            return "FormTextFieldTableViewCell"
        case .custom(let nibName):
            return nibName
        }
    }
}

//typealias FormCell = (BaseCell & CellValidatable)

class FormTableView: UITableView {
    
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
