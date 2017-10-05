//
//  ArrayValidationHelper.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

public enum ArrayValidationError: Error {
    case required
    case maxLength(UInt)
    case minLength(UInt)
    case exactLEngth(UInt)
}

class ArrayValidationHelper: NSObject {

    // MARK: - Get rules
    var required: (([Any]?) throws -> Void) {
        return { array in
            guard array != nil || array!.count >= 1 else {
                throw ArrayValidationError.required
            }
        }
    }
    
    var maxLength: (([Any], UInt) throws -> Void) {
        return { array, maxLength in
            guard array.count <= maxLength && array.count > 0 else {
                throw ArrayValidationError.maxLength(maxLength)
            }
        }
    }
    
    var minLength: (([Any], UInt) throws -> Void) {
        return { array, minLength in
            guard array.count > minLength && array.count > 0 else {             
                throw ArrayValidationError.minLength(minLength)
            }
        }
    }
    
    var exactLength: (([Any], UInt) throws -> Void) {
        return { array, exactLength in
            guard array.count == exactLength && array.count > 0 else {
                throw ArrayValidationError.exactLEngth(exactLength)
            }
        }
    }
}

