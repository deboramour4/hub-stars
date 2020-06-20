
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
        struct stars {
            static let size: CGFloat = 40
        }
    }
    
    // MARK: - UI Elements
    private var detailImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.image.size/2
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
    }
    
    // MARK: - Setup
    private func setupView() {
        accessoryType = .disclosureIndicator
        
        //way 1 and 2
//        textStackView.addArrangedSubview(titleLabel)
//        textStackView.addArrangedSubview(usernameLabel)
//
//        addSubview(detailImageView)
//        addSubview(textStackView)
//        addSubview(starsLabel)
        
        //way 3
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(starsLabel)
        textStackView.addArrangedSubview(usernameLabel)
        
        contentView.addSubview(detailImageView)
        contentView.addSubview(textStackView)
        starsLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            //way 1
//            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
//            detailImageView.heightAnchor.constraint(equalToConstant: Constants.image.size),
//            detailImageView.widthAnchor.constraint(equalToConstant: Constants.image.size),
//
//            textStackView.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: Constants.padding),
//            textStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding*2),
//            textStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding*2),
//
//            starsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            starsLabel.leadingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: Constants.padding),
//            starsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
//            starsLabel.widthAnchor.constraint(equalToConstant: Constants.image.size),
            
            //way 2
//            detailImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
//            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
//            detailImageView.heightAnchor.constraint(equalToConstant: Constants.image.size),
//            detailImageView.widthAnchor.constraint(equalToConstant: Constants.image.size),
//
//            textStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            textStackView.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: Constants.padding*2),
//            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding*2),
//
//            starsLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: Constants.padding/2),
//            starsLabel.leadingAnchor.constraint(equalTo: detailImageView.leadingAnchor),
//            starsLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor),
//            starsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            
            //way 3
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
    
    public func setup(with viewModel: RepoCellViewModel?) {
        if let viewModel = viewModel {
            titleLabel.backgroundColor = .clear
            starsLabel.backgroundColor = .clear
            usernameLabel.backgroundColor = .clear
            detailImageView.backgroundColor = .clear
            
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
        } else {
            titleLabel.backgroundColor = .tertiarySystemFill
            starsLabel.backgroundColor = .tertiarySystemFill
            usernameLabel.backgroundColor = .tertiarySystemFill
            detailImageView.backgroundColor = .tertiarySystemFill
            
            titleLabel.layer.masksToBounds = true
            starsLabel.layer.masksToBounds = true
            usernameLabel.layer.masksToBounds = true
            
            titleLabel.layer.cornerRadius = 8
            starsLabel.layer.cornerRadius = 8
            usernameLabel.layer.cornerRadius = 8
            
            titleLabel.text = " "
            starsLabel.text = " "
            usernameLabel.text = " "
        }
        
        setupView()
    }
    
}
