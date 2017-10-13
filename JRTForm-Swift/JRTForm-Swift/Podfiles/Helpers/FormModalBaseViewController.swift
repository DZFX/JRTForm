//
//  FormModalBaseViewController.swift
//  JRTForm-Swift
//
//  Created by Isaac Delgado on 10/13/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class FormModalBaseViewController: UIViewController {

    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    
    
    // MARK: - Private functions
    private func commonInit() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    // MARK: - Public functions
    public func show() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        viewController.present(self, animated: true, completion: nil)
    }
}
