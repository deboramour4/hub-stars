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
    
    // MARK: - UI Elements
    private var blurView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial))
        blur.isUserInteractionEnabled = false
        return blur
    }()
    
    // MARK: - Properties
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    var hasBlur: Bool = false {
        didSet {
            if hasBlur {
                insertSubview(blurView, at: 0)
            }
        }
    }
    
    override var frame: CGRect {
        didSet {
            if hasBlur {
                blurView.frame = bounds
            }
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
        
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    }
}

