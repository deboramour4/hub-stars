//
//  File.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - AppLabel
class AppLabel: UILabel {
    
    // MARK: - Constants
    private struct Constants {
        static let cornerRadius: CGFloat = 8
    }

    // MARK: - Properties
    override var text: String? {
        didSet {
            if let text = text, text != .space, text != .empty {
                customizeNormal()
            }
        }
    }

    var isLoading: Bool = true {
        didSet {
            if isLoading {
                customizeLoading()
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
        customizeLoading()
    }
    
    // MARK: - Private Functions
    private func customizeLoading() {
        backgroundColor = .quaternarySystemFill
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        text = String.space
    }

    private func customizeNormal() {
        isLoading = false
        backgroundColor = .clear
    }
}
