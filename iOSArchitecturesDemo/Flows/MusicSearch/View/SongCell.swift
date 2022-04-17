//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 16/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    static let reuseIdentifier = "reuseIdentifierSongCell"
    
    // MARK: - Subviews
    
    private(set) lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "music.note")
        }
        return imageView
    }()
    
    private(set) lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private(set) lazy var artworkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.trackLabel.text = cellModel.trackName
        self.artistLabel.text = cellModel.artistName
        self.collectionLabel.text = cellModel.collectionName
        self.artworkLabel.text = cellModel.artwork
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.trackLabel, self.artistLabel, self.collectionLabel, self.artworkLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addSongImage()
        self.addTrackLabel()
        self.addArtistLabel()
        self.addCollectionLabel()
        self.addArtistLabel()
    }
    
    private func addSongImage() {
        self.contentView.addSubview(self.songImageView)
        NSLayoutConstraint.activate([
            self.songImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.songImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.songImageView.heightAnchor.constraint(equalToConstant: 20.0),
            self.songImageView.widthAnchor.constraint(equalToConstant: 20.0)
            ])
    }
    
    private func addTrackLabel() {
        self.contentView.addSubview(self.trackLabel)
        NSLayoutConstraint.activate([
            self.trackLabel.centerYAnchor.constraint(equalTo: songImageView.centerYAnchor),
            self.trackLabel.leftAnchor.constraint(equalTo: songImageView.rightAnchor, constant: 4.0),
            self.trackLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addArtistLabel() {
        self.contentView.addSubview(self.artistLabel)
        NSLayoutConstraint.activate([
            self.artistLabel.topAnchor.constraint(equalTo: self.trackLabel.bottomAnchor, constant: 4.0),
            self.artistLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.artistLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addCollectionLabel() {
        self.contentView.addSubview(self.collectionLabel)
        NSLayoutConstraint.activate([
            self.collectionLabel.topAnchor.constraint(equalTo: self.artistLabel.bottomAnchor, constant: 4.0),
            self.collectionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.collectionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addArtworkLabel() {
        self.contentView.addSubview(self.artworkLabel)
        NSLayoutConstraint.activate([
            self.artworkLabel.topAnchor.constraint(equalTo: self.collectionLabel.bottomAnchor, constant: 4.0),
            self.artworkLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.artworkLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0),
            self.artworkLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4.0)
            ])
    }
}
