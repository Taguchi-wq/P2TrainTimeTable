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
    private var station = String()
    

    // MARK: - @IBOutlet
    /// 駅をし表示するUILabel
    @IBOutlet private weak var stationLabel: UILabel!
    /// 路線を表示するUITableView
    @IBOutlet private weak var lineTableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(lineTableView)
        makeUI(station: station)
    }
    
    
    // MARK: - Initializer
    // TODO: 強制的に呼ばせたい。。。
    func initialize(station: String) {
        self.station = station
    }
    
    
    // MARK: - Private Methods
    /// UITableViewを設定する
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    /// 画面のUIを作成
    private func makeUI(station: String) {
        stationLabel.text = station
        displayLineInTableView(station: station)
    }
    
    /// tableViewに路線を表示する
    private func displayLineInTableView(station: String) {
        NetworkManager.shared.loadStations(station) { (stations, error) in
            if let error = error {
                print(error)
            }
            
            guard let stations = stations else { return }
            self.stations.append(contentsOf: stations)
            DispatchQueue.main.async { self.lineTableView.reloadData() }
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
