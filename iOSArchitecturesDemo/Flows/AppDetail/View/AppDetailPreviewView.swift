//
//  AppDetailPreviewView.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 13/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailPreviewView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.addSubview(self.collectionView)
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8.0),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            self.collectionView.heightAnchor.constraint(equalToConstant: 300),
            self.collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
