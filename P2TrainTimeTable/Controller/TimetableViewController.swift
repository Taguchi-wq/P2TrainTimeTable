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
    }
    
}


// MARK: - UITableViewDataSource
extension TimetableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timetableCell = tableView.dequeueReusableCell(withIdentifier: "timetableCell", for: indexPath)
        return timetableCell
    }
    
}


// MARK: - Reusable
extension TimetableViewController: Reusable {}
