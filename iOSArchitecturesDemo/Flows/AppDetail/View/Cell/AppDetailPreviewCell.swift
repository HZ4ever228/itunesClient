//
//  AppDetailPreviewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 13/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailPreviewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "reuseIdentifierAppDetailPreviewCell"
    
    // MARK: - Subviews
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.addImageView()
    }
    
    private func addImageView() {
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
