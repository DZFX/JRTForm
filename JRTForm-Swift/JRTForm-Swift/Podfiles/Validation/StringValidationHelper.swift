//
//  StringValidationHelper.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

public enum StringValidationError: Error {
    case required
    case maxLenght(UInt)
    case minLenght(UInt)
    case exactLength(UInt)
    case alpha
    case alphaSpace
    case numeric
    case decimal
    case twoDecimals
    case email
}

class StringValidationHelper: NSObject {

    // MARK: - Get rules
    var required: ((String) throws -> Void) {
        return { string in
            if string.count < 1 {
                print("Is required")
                throw StringValidationError.required
            }
        }
    }
    
    var maxLength: ((String, UInt) throws -> Void) {
        return { string, maxLength in
            if string.count > maxLength && string.count > 0 {
                print("Cannot be more than \(maxLength) character(s).")
                throw StringValidationError.maxLenght(maxLength)
            }
        }
    }
    
    var minLength: ((String, UInt) throws -> Void) {
        return { string, minLength in
            if string.count < minLength && string.count > 0 {
                print("Cannot be less than \(minLength) character(s).")
                throw StringValidationError.minLenght(minLength)
            }
        }
    }
    
    var exactLength: ((String, UInt) throws -> Void) {
        return { string, exactLength in
            if string.count != exactLength && string.count > 0 {
                print("Must be exactly \(exactLength) character(s).")
                throw StringValidationError.exactLength(exactLength)
            }
        }
    }
    
    var alpha: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z]+") {
                print("Must be alphabetic characters only and no spaces.")
                throw StringValidationError.alpha
            }
        }
    }
    
    var alphaSpace: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z\\s]+") {
                print("Must be alphabetic characters only.")
                throw StringValidationError.alphaSpace
            }
        }
    }
    
    var numeric: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+") {
                print("Must be non-negative integers only only.")
                throw StringValidationError.numeric
            }
        }
    }
    
    var decimal: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9]+)?") {
                print("Must be non-negative decimal number only.")
                throw StringValidationError.decimal
            }
        }
    }
    
    var twoDecimals: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9][0-9])?") {
                print("Must be non-negative decimal number only (2 decimals max).")
                throw StringValidationError.twoDecimals
            }
        }
    }
    var email: ((String) throws -> Void) {
        return { string in
            if !self.test(string: string, withExpression: "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?") {
                print("Must be a valid email.")
                throw StringValidationError.email
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
