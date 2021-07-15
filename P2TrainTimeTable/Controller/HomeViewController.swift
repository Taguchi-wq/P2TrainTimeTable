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
    }
    
}
