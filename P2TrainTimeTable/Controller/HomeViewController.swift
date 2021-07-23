//
//  HomeViewController.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/15.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    /// お気に入りの駅を格納する配列
    private var favoriteStations: Results<FavoriteStation>!
    

    // MARK: - @IBOutlet
    /// 駅を検索するUISearchBar
    @IBOutlet private weak var searchBar: UISearchBar!
    /// お気に入りを表示するUITableView
    @IBOutlet private weak var favoritesTableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar(searchBar)
        setupTableView(favoritesTableView)
        setupTapGesture(favoritesTableView)
        appendFavoriteStation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoritesTableView.reloadData()
    }
    
    
    // MARK: - Private Methods
    /// SearchBarの設定をする
    private func setupSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    /// TableViewの設定をする
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    /// TapGestureの設定をする
    private func setupTapGesture(_ tableView: UITableView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    /// お気に入りをか配列に入れる
    private func appendFavoriteStation() {
        let favoriteStations = RealmManager.shared.load(FavoriteStation.self)
        self.favoriteStations = favoriteStations
    }
    
    /// SearchResultViewControllerに遷移する
    private func transitionToSearchResultViewController(stationTitle: String) {
        let searchResultViewController = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.reuseIdentifier) as! SearchResultViewController
        searchResultViewController.initialize(stationTitle: stationTitle)
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
    
    // MARK: - @objc Methods
    /// キーボードを隠す
    @objc private func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
}


// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteStationCell = tableView.dequeueReusableCell(withIdentifier: "favoriteStationCell", for: indexPath)
        let favoriteStation = favoriteStations[indexPath.row]
        favoriteStationCell.textLabel?.text = "\(favoriteStation.title ?? "") - \(favoriteStation.line ?? "")"
        return favoriteStationCell
    }
    
}


// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "お気に入り"
    }
    
}


// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    /// キーボードの「検索」ボタンを押した時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let stationTitle = searchBar.text else { return }
        transitionToSearchResultViewController(stationTitle: stationTitle)
        hideKeyboard()
    }
    
}
