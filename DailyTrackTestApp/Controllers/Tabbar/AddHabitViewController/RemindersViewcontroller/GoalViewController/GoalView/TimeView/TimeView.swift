//
//  TimeView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 29/11/24.
//

import UIKit

class TimeView: NibView {
    
    // MARK: - Outlets
    @IBOutlet private weak var TimeTableView: UITableView!
    
    // MARK: - Variables
    private let listTime = ["min", "times"]
    
    
    // MARK: - Life cycles
    override func configureView() {
        super.configureView()
        setupUI()
    }
}

// MARK: - Custom methods
extension TimeView {
    
    private func setupUI() {
        registerCell()
    }
    private func registerCell() {
        TimeTableView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeTableViewCell")
        TimeTableView.delegate = self
        TimeTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TimeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as? TimeTableViewCell else
        { return UITableViewCell() }
        cell.configureTimeView(data: listTime[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36
    }
}
