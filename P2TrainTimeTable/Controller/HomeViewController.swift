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
        guard let searchResultViewController = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.reuseIdentifier) as? SearchResultViewController else { return }
        searchResultViewController.initialize(stationTitle: stationTitle)
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
    /// TimetableViewControllerに遷移する
    private func transitionToTimetableViewController(indexPath: IndexPath) {
        // お気に入りに登録されている駅のIDを取得する
        guard let stationID = favoriteStations[indexPath.row].id else { return }
        // IDから駅を検索するURLを取得する
        guard let url = URL.stationIDURL(stationID) else { return }
        // URLから駅の情報を読み込む
        NetworkManager.shared.load(url, type: Station.self) { (stations, error) in
            if let error = error {
                print(error)
            }
            
            // 駅はIDから取得するので結果は１つ
            // なので、配列の最初を取得する
            guard let station = stations?.first else { return }
            // TimetableViewControllerに駅を渡して遷移する
            guard let timetableViewController = self.storyboard?.instantiateViewController(withIdentifier: TimetableViewController.reuseIdentifier) as? TimetableViewController else { return }
            timetableViewController.initialize(station: station)
            self.navigationController?.pushViewController(timetableViewController, animated: true)
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToTimetableViewController(indexPath: indexPath)
    }
    
    /// tableView上で削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // お気に入りから駅を削除する
            RealmManager.shared.deleteFavoriteStation(favoriteStations[indexPath.row])
            // favoritesTableViewから駅を削除する
            favoritesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
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
