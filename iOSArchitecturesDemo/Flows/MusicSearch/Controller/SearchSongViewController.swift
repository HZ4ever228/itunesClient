//
//  SearchSongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Anton Hodyna on 16/04/2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchSongViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: SearchSongViewOutput
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    var searchResults = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - Construction
    
    init(presenter: SearchSongViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        addAppButton()
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    //MARK: - Private functions
    
    private func addAppButton() {
        let appButton = UIButton(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        appButton.addTarget(self, action: #selector(appButtunActionTap), for: UIControl.Event.touchUpInside)
        if #available(iOS 13.0, *) {
            appButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        }
        let appButtonItem = UIBarButtonItem(customView: appButton)
        navigationItem.setRightBarButtonItems([appButtonItem], animated: true)
    }
    
    //MARK: - @objc private functions
    
    @objc private func appButtunActionTap() {
        let roorVC = SearchModuleBuilder.build()
        roorVC.navigationItem.title = "Search Apps"
        
        navigationController?.viewControllers = [roorVC]
    }
}

//MARK: - UITableViewDataSource
extension SearchSongViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? SongCell else {
            return dequeuedCell
        }
        let song = self.searchResults[indexPath.row]
        let cellModel = SongCellModelFactory.cellModel(from: song)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchSongViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //song is choosen
    }
}

//MARK: - UISearchBarDelegate
extension SearchSongViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }

        presenter.viewDidSearch(with: query)
    }
}

extension SearchSongViewController: SearchSongViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
        
        self.searchResults = []
        searchView.tableView.reloadData()
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}

