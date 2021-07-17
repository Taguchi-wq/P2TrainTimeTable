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
    }
    
    
    // MARK: - Private Methods
    /// UITableViewを設定する
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
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
