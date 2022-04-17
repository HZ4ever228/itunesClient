//
//  ScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 14/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

import UIKit

class ScreenshotsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let imageArray: [UIImage]
    
    private var screenshotsView: ScreenshotsView {
        return self.view as! ScreenshotsView
    }
    
    
    // MARK: - Construction
    
    init(imageArray: [UIImage]) {
        self.imageArray = imageArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = ScreenshotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
    }
    
    // MARK: - Private functions
    
    private func addCollectionView() {
        screenshotsView.collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: AppDetailPreviewCell.reuseIdentifier)
        screenshotsView.collectionView.delegate = self
        screenshotsView.collectionView.dataSource = self
    }
    
}

//MARK: - UICollectionViewDelegate

extension ScreenshotsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.row)")
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.2, height: collectionView.frame.height / 1.2)
    }
    
}

//MARK: - UICollectionViewDataSource

extension ScreenshotsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailPreviewCell.reuseIdentifier, for: indexPath) as? AppDetailPreviewCell {
            let cellImage = imageArray[indexPath.row]
            cell.configure(with: cellImage)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
}
