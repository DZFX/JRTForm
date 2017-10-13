//
//  ArrayValidationHelper.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
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

