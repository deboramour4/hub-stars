//
//  AppImage.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - AppImageView
class AppImageView: UIImageView {
        
    // MARK: - Properties
    var isCircle: Bool = false
    
    override var image: UIImage? {
        didSet {
            if image != nil {
                customizeNormal()
            } else {
                customizeLoading()
            }
        }
    }

    // MARK: - Initializers
    convenience init(isCircle: Bool) {
        self.init(frame: .zero)
        self.isCircle = isCircle
    }

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
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        if isCircle {
            layer.masksToBounds = true
            layer.cornerRadius = frame.width/2
        }
    }
    
    // MARK: - Private Functions
    private func customizeLoading() {
        backgroundColor = .quaternarySystemFill
    }
    
    private func customizeNormal() {
        backgroundColor = .clear
    }
}
