//
//  AppDetailsWhatsNewsView.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 13/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailsWhatsNewsView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "Что нового"
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var versionHistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("История версий", for: .normal)
        return button
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var versionDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private(set) lazy var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(versionHistoryButton)
        addSubview(versionLabel)
        addSubview(versionDataLabel)
        addSubview(whatsNewLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.versionHistoryButton.leftAnchor, constant: 16.0),
            self.versionHistoryButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.versionHistoryButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            self.versionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.0),
            self.versionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            self.versionLabel.rightAnchor.constraint(equalTo: self.versionDataLabel.leftAnchor, constant: 16.0),
            self.versionDataLabel.centerYAnchor.constraint(equalTo: self.versionLabel.centerYAnchor),
            self.versionDataLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            self.whatsNewLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 16.0),
            self.whatsNewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            self.whatsNewLabel.rightAnchor.constraint(equalTo: self.versionHistoryButton.leftAnchor, constant: 16.0),
            self.whatsNewLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
