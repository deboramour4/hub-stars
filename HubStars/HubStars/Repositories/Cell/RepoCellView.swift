
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
        struct image {
            static let size: CGFloat = 80
        }
    }
    
    // MARK: - UI Elements
    private var detailImageView: AppImageView = {
        let image = AppImageView(isCircle: true)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private var titleLabel: AppLabel = {
        let label = AppLabel(frame: .zero)
        label.font = UIFont.h1
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var usernameLabel: AppLabel = {
        let label = AppLabel(frame: .zero)
        label.font = UIFont.h3
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var starsLabel: AppLabel = {
        let label = AppLabel(frame: .zero)
        label.font = UIFont.h2
        label.textColor = UIColor.label
        label.textAlignment = .center
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
        titleLabel.isLoading = true
        starsLabel.isLoading = true
        usernameLabel.isLoading = true
    }
    
    // MARK: - Setup
    private func setupView() {
        accessoryType = .disclosureIndicator

        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(starsLabel)
        textStackView.addArrangedSubview(usernameLabel)
        
        contentView.addSubview(detailImageView)
        contentView.addSubview(textStackView)
        starsLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            detailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            detailImageView.heightAnchor.constraint(equalToConstant: Constants.image.size),
            detailImageView.widthAnchor.constraint(equalToConstant: Constants.image.size),
            
            textStackView.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: Constants.padding),
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding*2),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding*2),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding/2)
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.vertical)
        starsLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.vertical)
    }
    
    public func setup(with viewModel: RepoCellViewModelProtocol?) {
        if var viewModel = viewModel {
            titleLabel.text = viewModel.repoTitleText
            starsLabel.text = viewModel.starsCountText
            usernameLabel.text = viewModel.usernameText
            
            viewModel.successOnRequest = { [weak self] data in
                DispatchQueue.main.async {
                    if let data = data {
                        self?.detailImageView.image = UIImage(data: data)
                    }
                }
            }
            
            viewModel.errorOnRequest = { [weak self] in
                DispatchQueue.main.async {
                    self?.detailImageView.image = UIImage(named: "placeholder")
                }
            }
            
            viewModel.getImageData()
        }
        
        setupView()
    }
}
