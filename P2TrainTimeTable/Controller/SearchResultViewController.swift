//
//  SearchResultViewController.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/15.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    // MARK: - Properties
    /// 駅を格納する配列
    private var stations: [Station] = []
    

    // MARK: - @IBOutlet
    /// 駅をし表示するUILabel
    @IBOutlet private weak var stationLabel: UILabel!
    /// 路線を表示するUITableView
    @IBOutlet private weak var lineTableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(lineTableView)
        displayLineInTableView()
    }
    
    
    // MARK: - Private Methods
    /// UITableViewを設定する
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
    }
    
    /// tableViewに路線を表示する
    private func displayLineInTableView() {
        let station = "大久保"
        let encodeStation = station.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let url = URL(string: "https://api-tokyochallenge.odpt.org/api/v4/odpt:Station?dc:title=\(encodeStation)&acl:consumerKey=75LyUzspYl2pkwGesTzDTWWiOj-9xz9NnE_KU9yR7pU")
        NetworkManager.shared.loadStations(url) { stations in
            self.stations.append(contentsOf: stations)
            DispatchQueue.main.async { self.lineTableView.reloadData() }
        }
    }

}


// MARK: - UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = stations[indexPath.row].railway
        return cell
    }
    
}


// MARK: - Reusable
extension SearchResultViewController: Reusable {}
