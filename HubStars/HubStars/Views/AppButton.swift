//
//  Appbutton.swift
//  HubStars
//
//  Created by Debora Moura on 21/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - AppButton
class AppButton: UIButton {
    
    // MARK: - Constants
    private struct Constants {
        static let height: CGFloat = 50
    }
    
    // MARK: - Properties
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        setTitleColor(UIColor.label, for: .normal)
        layer.masksToBounds = true
        layer.cornerRadius = Constants.height/2
        titleLabel?.font = UIFont.button
        
        backgroundColor = UIColor.primary(alpha: 0.9)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height)
        ])
    }
}
