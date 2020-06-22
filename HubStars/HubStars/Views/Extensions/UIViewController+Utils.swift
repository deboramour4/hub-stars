//
//  UIViewController+Utils.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - Extension UIViewController
extension UIViewController {
    func presentAlert(_ title: String?,
                      message: String?,
                      actionTitle: String?,
                      dismissTitle: String? = nil,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        if let title = dismissTitle {
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        }
        alert.view.tintColor = UIColor.label
        present(alert, animated: true, completion: nil)
    }
}
