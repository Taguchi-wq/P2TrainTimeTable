//
//  TimetableViewController.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/17.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    // MARK: - Enums
    /// 方向
    private enum Direction: Int {
        case up   = 0
        case down = 1
    }
    
    /// 曜日種別と方面
    private enum StationTimetable: Int {
        case weekdayUp   = 0
        case holidayUp   = 1
        case weekdayDown = 2
        case holidayDown = 3
    }
    
    
    /// MARK: - Properties
    /// タイムテーブルの情報を格納する配列
    private var timetable: [Timetable] = []
    /// 駅
    private var station: Station?
    
    
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
        displayTimetableInTableView(stationTimetable: station.stationTimetable?[StationTimetable.weekdayUp.rawValue])
    }
    
    /// tableViewをリロードする
    private func reloadTableView(timetable: [Timetable]?) {
        guard let timetable = timetable else { return }
        self.timetable = []
        self.timetable.append(contentsOf: timetable)
        self.timetableTableView.reloadData()
    }
    
    /// tableViewにタイムテーブルを表示する
    private func displayTimetableInTableView(stationTimetable: String?) {
        guard let stationTimetable = stationTimetable else { return }
        guard let url = URL.stationTimetableURL(stationTimetable) else { return }
        NetworkManager.shared.load(url, type: Timetable.self) { (timetable, error) in
            if let error = error {
                print(error)
            }
            
            self.reloadTableView(timetable: timetable)
        }
    }
    
    
    // MARK: - @IBActions
    /// 方面を選んだ時に呼ばれる
    @IBAction private func selectedDirection(_ sender: UISegmentedControl) {
        guard let station = station else { return }
        
        let direction = Direction(rawValue: sender.selectedSegmentIndex) ?? .up
        switch direction {
        case .up:
            displayTimetableInTableView(stationTimetable: station.stationTimetable?[StationTimetable.weekdayUp.rawValue])
        case .down:
            displayTimetableInTableView(stationTimetable: station.stationTimetable?[StationTimetable.weekdayDown.rawValue])
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
