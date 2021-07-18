//
//  TimetableViewController.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/17.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    /// MARK: - Properties
    /// タイムテーブルの情報を格納する配列
    private var timetable: [Timetable] = []
    /// 駅
    private var station: Station?
    /// URL
    private let baseURL = "https://api-tokyochallenge.odpt.org/api/v4/"
    private let type    = "odpt:StationTimetable?"
    private let sameAs  = "owl:sameAs="
    private let apiKey  = "&acl:consumerKey=75LyUzspYl2pkwGesTzDTWWiOj-9xz9NnE_KU9yR7pU"
    
    
    // MARK: - @IBOutlets
    /// 駅と路線を表示するUILabel
    @IBOutlet private weak var stationLineLabel: UILabel!
    /// お気に入りボタン
    @IBOutlet private weak var favoriteButton: UIButton!
    /// 方面の切り替えをするUISegmentedControl
    @IBOutlet private weak var directionSegmentedControl: UISegmentedControl!
    /// タイムテーブルを表示するUITableView
    @IBOutlet private weak var timetableTableView: UITableView!
    
    
    /// MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(timetableTableView)
        makeUI(station: station)
    }
    
    
    // MARK: - Initializer
    // TODO: 強制的に呼ばせたい。。。
    func initialize(station: Station) {
        self.station = station
    }
    
    
    // MARK: - Private Methods
    /// UITableViewを設定する
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
    }
    
    /// 画面のUIを作成する
    private func makeUI(station: Station?) {
        guard let station = station else { return }
        stationLineLabel.text = "\(station.title) - \(station.railway)"
        displayTimetableInTableView(stationTimetable: station.stationTimetable?.first)
    }
    
    /// tableViewをリロードする
    private func reloadTableView(timetable: [Timetable]?) {
        guard let timetable = timetable else { return }
        self.timetable.append(contentsOf: timetable)
        self.timetableTableView.reloadData()
    }
    
    /// tableViewにタイムテーブルを表示する
    private func displayTimetableInTableView(stationTimetable: String?) {
        guard let stationTimetable = stationTimetable else { return }
        let urlString = baseURL + type + sameAs + stationTimetable + apiKey
        guard let url = URL(string: urlString) else { return }
        NetworkManager.shared.load(url, type: Timetable.self) { (timetable, error) in
            if let error = error {
                print(error)
            }
            
            self.reloadTableView(timetable: timetable)
        }
    }
    
}


// MARK: - UITableViewDataSource
extension TimetableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timetableObjects = timetable.first?.timetableObject else { return 0 }
        return timetableObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timetableCell = tableView.dequeueReusableCell(withIdentifier: "timetableCell", for: indexPath)
        let timetableObject = timetable.first?.timetableObject[indexPath.row]
        timetableCell.textLabel?.text = timetableObject?.departureTime
        return timetableCell
    }
    
}


// MARK: - Reusable
extension TimetableViewController: Reusable {}
