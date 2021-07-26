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
    /// 今日
    private let today = Date()
    
    
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
        setupButton(favoriteButton)
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
        tableView.delegate   = self
    }
    
    /// UIButtonの設定をする
    private func setupButton(_ button: UIButton) {
        button.setImage(UIImage(named: Image.star.name), for: .normal)
        button.setImage(UIImage(named: Image.starFill.name), for: .selected)
        
        // お気に入りボタンの画像の状態
        guard let station = station else { return }
        button.isSelected = station.isSaved
    }
    
    /// 画面のUIを作成する
    private func makeUI(station: Station?) {
        guard let station = station else { return }
        stationLineLabel.text = "\(station.title) - \(station.railway)"
        displayUpTimetable(station: station)
    }
    
    /// tableViewをリロードする
    private func reloadTableView(timetable: [Timetable]?) {
        guard let timetable = timetable else { return }
        self.timetable = []
        self.timetable.append(contentsOf: timetable)
        self.timetableTableView.reloadData()
    }
    
    /// tableViewにタイムテーブルを表示する
    private func displayTimetable(stationTimetable: String?) {
        guard let stationTimetable = stationTimetable else {
            timetable = []
            timetableTableView.reloadData()
            return
        }
        
        guard let url = URL.stationTimetableURL(stationTimetable) else { return }
        NetworkManager.shared.load(url, type: Timetable.self) { (timetable, error) in
            if let error = error {
                print(error)
            }
            
            self.reloadTableView(timetable: timetable)
        }
    }
    
    /// 上りのタイムテーブルを表示する
    private func displayUpTimetable(station: Station) {
        let timetable = today.isHoliday ? StationTimetable.holidayUp.rawValue : StationTimetable.weekdayUp.rawValue
        let upTimetable = station.stationTimetable?[safe: timetable]
        displayTimetable(stationTimetable: upTimetable)
    }
    
    /// 下りのタイムテーブルを表示する
    private func displayDownTimetable(station: Station) {
        let timetable = today.isHoliday ? StationTimetable.holidayDown.rawValue : StationTimetable.weekdayDown.rawValue
        let downTimetable = station.stationTimetable?[safe: timetable]
        displayTimetable(stationTimetable: downTimetable)
    }
    
    /// 駅をRealmに保存する
    private func save(station: Station) {
        let favoriteStation = FavoriteStation(id: station.id, title: station.title, line: station.railway)
        RealmManager.shared.writeFavoriteStation(favoriteStation)
        Alert.presentSavedStation(on: self)
    }
    
    /// 駅をRealmから削除する
    private func delete(station: Station) {
        guard let favoriteStation = RealmManager.shared.loadFavoriteStationByPrimaryKey(station.id) else { return }
        RealmManager.shared.deleteFavoriteStation(favoriteStation)
        Alert.presentDeletedStation(on: self)
    }
    
    
    // MARK: - @IBActions
    /// 方面を選んだ時に呼ばれる
    @IBAction private func selectedDirection(_ sender: UISegmentedControl) {
        guard let station = station else { return }
        let direction = Direction(rawValue: sender.selectedSegmentIndex) ?? .up
        switch direction {
        case .up:
            displayUpTimetable(station: station)
        case .down:
            displayDownTimetable(station: station)
        }
        
    }
    
    /// お気に入りボタンを押した時の処理
    @IBAction private func tappedFavoriteButton(_ sender: UIButton) {
        guard let station = station else { return }
        // 駅が保存されていたら削除
        // 保存されていなかったら保存
        station.isSaved ? delete(station: station) : save(station: station)
        // お気に入りボタンの画像を変える
        sender.isSelected = station.isSaved
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


// MARK: - UITableViewDelegate
extension TimetableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "時刻表"
    }
    
}


// MARK: - Reusable
extension TimetableViewController: Reusable {}
