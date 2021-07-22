//
//  HomeViewController.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/15.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - @IBOutlet
    /// 駅を検索するUISearchBar
    @IBOutlet private weak var searchBar: UISearchBar!
    /// お気に入りを表示するUITableView
    @IBOutlet private weak var favoritesTableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar(searchBar)
    }
    
    
    // MARK: - Private Methods
    /// SearchBarの設定をする
    private func setupSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    /// SearchResultViewControllerに遷移する
    private func transitionToSearchResultViewController(stationTitle: String) {
        let searchResultViewController = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.reuseIdentifier) as! SearchResultViewController
        searchResultViewController.initialize(stationTitle: stationTitle)
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
}


// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    /// キーボードの「検索」ボタンを押した時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let stationTitle = searchBar.text else { return }
        transitionToSearchResultViewController(stationTitle: stationTitle)
    }
    
}
