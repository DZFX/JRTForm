//
//  ArrayValidationHelper.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

public enum ArrayValidationError: Error {
    case required(String)
    case maxLength(UInt, String)
    case minLength(UInt, String)
    case exactLEngth(UInt, String)
}

class ArrayValidationHelper: NSObject {

    // MARK: - Get rules
    var required: (([Any]?) throws -> Void) {
        return { array in
            guard array != nil || array!.count >= 1 else {
                throw ArrayValidationError.required("is required")
            }
        }
    }
    
    var maxLength: (([Any], UInt) throws -> Void) {
        return { array, maxLength in
            guard array.count <= maxLength && array.count > 0 else {
                throw ArrayValidationError.maxLength(maxLength, "should have at most \(maxLength) elements")
            }
        }
    }
    
    var minLength: (([Any], UInt) throws -> Void) {
        return { array, minLength in
            guard array.count > minLength && array.count > 0 else {             
                throw ArrayValidationError.minLength(minLength, "should have at least \(minLength) elements")
            }
        }
    }
    
    var exactLength: (([Any], UInt) throws -> Void) {
        return { array, exactLength in
            guard array.count == exactLength && array.count > 0 else {
                throw ArrayValidationError.exactLEngth(exactLength, "must have exactly \(exactLength) elements")
            }
        }
    }
}

