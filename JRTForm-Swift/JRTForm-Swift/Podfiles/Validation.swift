//
//  Validation.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/3/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class Validation: NSObject {

    // MARK: - Get rules
    var required: ((String) -> String?) {
        return { string in
            return string.count < 1 ? "is required." : nil
        }
    }
    
    var maxLength: ((String, UInt) -> String?) {
        return { string, maxLength in
            if string.count > maxLength && string.count > 0 {
                return "Cannot be more than \(maxLength) character(s)."
            } else {
                return nil
            }
        }
    }
    
    var minLength: ((String, UInt) -> String?) {
        return { string, minLength in
            if string.count < minLength && string.count > 0 {
                return "Cannot be less than \(minLength) character(s)."
            } else {
                return nil
            }
        }
    }
    
    var exactLength: ((String, UInt) -> String?) {
        return { string, exactLength in
            if string.count != exactLength && string.count > 0 {
                return "Must be exactly \(exactLength) character(s)."
            } else {
                return nil
            }
        }
    }
    
    var alpha: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z]+") {
                return "Must be alphabetic characters only and no spaces."
            } else {
                return nil
            }
        }
    }
    
    var alphaSpace: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[a-zA-Z\\s]+") {
                return "Must be alphabetic characters only."
            } else {
                return nil
            }
        }
    }
    
    var numeric: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+") {
                return "Must be non-negative integers only only."
            } else {
                return nil
            }
        }
    }
    
    var decimal: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9]+)?") {
                return "Must be non-negative decimal number only."
            } else {
                return nil
            }
        }
    }
    
    var twoDecimals: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[0-9]+(\\.[0-9][0-9])?") {
                return "Must be non-negative decimal number only (2 decimals max)."
            } else {
                return nil
            }
        }
    }
    var email: ((String) -> String?) {
        return { string in
            if !self.test(string: string, withExpression: "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?") {
                return "Must be a valid email."
            } else {
                return nil
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
