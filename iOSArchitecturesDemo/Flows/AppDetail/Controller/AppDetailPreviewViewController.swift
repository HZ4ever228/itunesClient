//
//  AppDetailPreviewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 13/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailPreviewViewController: UIViewController {
    
    private var imageArray: [UIImage] = []
    
    //MARK: - Private properties
    
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    
    private var appDetailPreviewView: AppDetailPreviewView {
        return self.view as! AppDetailPreviewView
    }
    
    
    // MARK: - Construction
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailPreviewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImages()
        addCollectionView()
    }
    
    // MARK: - Private functions
    
    private func addCollectionView() {
        appDetailPreviewView.collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: AppDetailPreviewCell.reuseIdentifier)
        appDetailPreviewView.collectionView.delegate = self
        appDetailPreviewView.collectionView.dataSource = self
    }
    
    private func addImages() {
        for imageUrl in app.screenshotUrls {
            imageDownloader.getImage(fromUrl: imageUrl, completion: { image, _ in
                if let image = image {
                    self.imageArray.append(image)
                }
            })
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension AppDetailPreviewViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !imageArray.isEmpty {
            collectionView.deselectItem(at: indexPath, animated: true)
            let screenshotsViewController = ScreenshotsViewController(imageArray: imageArray)
            screenshotsViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            screenshotsViewController.modalPresentationStyle = .pageSheet
            screenshotsViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            present(screenshotsViewController, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension AppDetailPreviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.2, height: collectionView.frame.width / 1.2)
    }
    
}

//MARK: - UICollectionViewDataSource

extension AppDetailPreviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailPreviewCell.reuseIdentifier, for: indexPath) as? AppDetailPreviewCell {
            
            if !imageArray.isEmpty {
                print("configure from imageArray")
                let image = imageArray[indexPath.row]
                cell.configure(with: image)
            } else {
                print("configure from imageDownloader")
                let imageUrl = app.screenshotUrls[indexPath.row]
                imageDownloader.getImage(fromUrl: imageUrl, completion: { image, _ in
                    if let image = image {
                        cell.configure(with: image)
                    }
                })
            }
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
}
