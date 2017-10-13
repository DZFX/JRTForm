//
//  StringValidationHelper.swift
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

public enum StringValidationError: Error {
    case required(String)
    case maxLength(UInt, String)
    case minLength(UInt, String)
    case exactLength(UInt, String)
    case alpha(String)
    case alphaSpace(String)
    case numeric(String)
    case decimal(String)
    case twoDecimals(String)
    case email(String)
}

class StringValidationHelper: NSObject {

    // MARK: - Get rules
    var required: ((String) throws -> Void) {
        return { string in
            if string.count < 1 {
                throw StringValidationError.required("is required")
            }
        }
    }
    
    var maxLength: ((String, UInt) throws -> Void) {
        return { string, maxLength in
            if string.count > maxLength && string.count > 0 {
                throw StringValidationError.maxLength(maxLength, "cannot be more than \(maxLength) character(s).")
            }
        }
    }
    
    var minLength: ((String, UInt) throws -> Void) {
        return { string, minLength in
            if string.count < minLength && string.count > 0 {
                throw StringValidationError.minLength(minLength, "cannot be less than \(minLength) character(s).")
            }
        }
    }
    
    var exactLength: ((String, UInt) throws -> Void) {
        return { string, exactLength in
            if string.count != exactLength && string.count > 0 {
                throw StringValidationError.exactLength(exactLength, "must be exactly \(exactLength) character(s).")
            }
        }
    }
    
    var alpha: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z]+") {
                throw StringValidationError.alpha("must be alphabetic characters only and no spaces.")
            }
        }
    }
    
    var alphaSpace: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z\\s]+") {
                throw StringValidationError.alphaSpace("must be alphabetic characters only.")
            }
        }
    }
    
    var numeric: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+") {
                throw StringValidationError.numeric("must be non-negative integers only only.")
            }
        }
    }
    
    var decimal: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9]+)?") {
                throw StringValidationError.decimal("must be non-negative decimal number only.")
            }
        }
    }
    
    var twoDecimals: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9][0-9])?") {
                throw StringValidationError.twoDecimals("must be non-negative decimal number only (2 decimals max).")
            }
        }
    }
    var email: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?") {
                throw StringValidationError.email("must be a valid email.")
            }
        }
    }
    
    // MARK: - Helpers
    func test(string: String, withExpression regularExpression: String) -> Bool {
        guard string.count > 0 else {
            return true
        }
        let test = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return test.evaluate(with: string)
    }
}
