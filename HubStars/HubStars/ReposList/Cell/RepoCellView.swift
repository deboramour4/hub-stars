
//
//  RepoViewCell.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - RepoCellView
final class RepoCellView: UITableViewCell {

    // MARK: - Constants
    private struct Constants {
        static let padding: CGFloat = 8
        static let itemSize: CGFloat = 50
        static let labelHeight: CGFloat = 25
    }
    
    // MARK: - UI Elements
    private var detailImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.itemSize/2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.h1
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var usernameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.h3
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var starsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.h2
        label.textColor = UIColor.label
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func prepareForReuse() {
        detailImageView.image = nil
    }
    
    // MARK: - Setup
    private func setupView() {        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(usernameLabel)
        
        addSubview(detailImageView)
        addSubview(textStackView)
        addSubview(starsLabel)
        
        NSLayoutConstraint.activate([
            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            detailImageView.heightAnchor.constraint(equalToConstant: Constants.itemSize),
            detailImageView.widthAnchor.constraint(equalToConstant: Constants.itemSize),
            
            textStackView.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: Constants.padding),
            textStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding*2),
            textStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding*2),
            
            starsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            starsLabel.leadingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: Constants.padding),
            starsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            starsLabel.widthAnchor.constraint(equalToConstant: Constants.itemSize*1.3),
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.vertical)
    }
    
    public func setup(with viewModel: RepoCellViewModel) {
        titleLabel.text = viewModel.repoTitleText
        starsLabel.text = viewModel.starsCountText
        usernameLabel.text = viewModel.usernameText
        
        viewModel.onRequest = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.detailImageView.backgroundColor = isLoading ? .lightGray : .clear
            }
        }
        
        viewModel.successOnRequest = { [weak self] data in
            DispatchQueue.main.async {
                if let data = data {
                    self?.detailImageView.image = UIImage(data: data)
                }
            }
        }
        
        viewModel.errorOnRequest = { [weak self] in
            DispatchQueue.main.async {
                self?.detailImageView.backgroundColor = .red
            }
        }

        viewModel.getImageData()
        
        setupView()
    }
    
}
