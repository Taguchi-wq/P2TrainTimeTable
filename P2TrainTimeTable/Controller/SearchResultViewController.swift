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
    /// 検索バーに入力された駅名
    private var stationTitle = String()
    /// URL
    private let baseURL     = "https://api-tokyochallenge.odpt.org/api/v4/"
    private let type        = "odpt:Station?"
    private let searchTitle = "dc:title="
    private let apiKey      = "&acl:consumerKey=75LyUzspYl2pkwGesTzDTWWiOj-9xz9NnE_KU9yR7pU"

    
    // MARK: - @IBOutlet
    /// 駅を表示するUILabel
    @IBOutlet private weak var stationLabel: UILabel!
    /// 路線を表示するUITableView
    @IBOutlet private weak var lineTableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(lineTableView)
        makeUI(stationTitle: stationTitle)
    }
    
    
    // MARK: - Initializer
    // TODO: 強制的に呼ばせたい。。。
    func initialize(stationTitle: String) {
        self.stationTitle = stationTitle
    }
    
    
    // MARK: - Private Methods
    /// UITableViewを設定する
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    /// 画面のUIを作成
    private func makeUI(stationTitle: String) {
        stationLabel.text = stationTitle
        displayLineInTableView(stationTitle: stationTitle)
    }
    
    /// tableViewをリロードする
    private func reloadTableView(stations: [Station]?) {
        guard let stations = stations else { return }
        self.stations.append(contentsOf: stations)
        self.lineTableView.reloadData()
    }
    
    /// tableViewに路線を表示する
    private func displayLineInTableView(stationTitle: String) {
        let encodeStation = stationTitle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let urlString = baseURL + type + searchTitle + encodeStation + apiKey
        guard let url = URL(string: urlString) else { return }
        NetworkManager.shared.load(url, type: Station.self) { (stations, error) in
            if let error = error {
                print(error)
            }
            
            self.reloadTableView(stations: stations)
        }
    }
    
    /// TimetableViewControllerに遷移する
    private func transitionToTimetableViewController(indexPath: IndexPath) {
        let timetableViewController = storyboard?.instantiateViewController(withIdentifier: TimetableViewController.reuseIdentifier) as! TimetableViewController
        timetableViewController.initialize(station: stations[indexPath.row])
        navigationController?.pushViewController(timetableViewController, animated: true)
    }

}


// MARK: - UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lineCell = tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath)
        lineCell.textLabel?.text = stations[indexPath.row].railway
        return lineCell
    }
    
}


// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToTimetableViewController(indexPath: indexPath)
    }
    
}

// MARK: - Reusable
extension SearchResultViewController: Reusable {}
