//
//  ArrayValidationHelper.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class ArrayValidationHelper: NSObject {

    // MARK: - Get rules
    var required: (([Any]?) -> String?) {
        return { array in
            guard array != nil || array!.count >= 1 else {
                return "is required."
            }
            return nil
        }
    }
    
    var maxLength: (([Any], UInt) -> String?) {
        return { array, maxLength in
            guard array.count <= maxLength && array.count > 0 else {
                return "cannot be more than \(maxLength) elements."
            }
            return nil
        }
    }
    
    var minLength: (([Any], UInt) -> String?) {
        return { array, minLength in
            guard array.count > minLength && array.count > 0 else {
                return "cannot be less than \(minLength) elements."
            }
            return nil
        }
    }
    
    var exactLength: (([Any], UInt) -> String?) {
        return { array, exactLength in
            guard array.count == exactLength && array.count > 0 else {
                return "must be exactly \(exactLength) elements."
            }
            return nil
        }
    }
}
