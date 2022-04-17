//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 16/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongViewInput: class {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: class {
    func viewDidSearch(with query: String)
}

class SearchSongPresenter {
    
    weak var viewInput: (UIViewController & SearchSongViewInput)?
    
    private let searchService = ITunesSearchService()
    
    private func requestSong(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.searchResults = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
}

extension SearchSongPresenter: SearchSongViewOutput {
    
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestSong(with: query)
    }
}
