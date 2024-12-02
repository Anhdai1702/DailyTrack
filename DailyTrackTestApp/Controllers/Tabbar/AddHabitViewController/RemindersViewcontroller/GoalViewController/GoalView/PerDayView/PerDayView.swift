//
//  PerDayView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 29/11/24.
//

import UIKit

class PerDayView: NibView {
    // MARK: - Outlets
    @IBOutlet private weak var perDayTableView: UITableView!
    
    // MARK: - Variables
    private let listPerDay = ["per day", "per week", "per month"]
    
    // MARK: - Life cycles
    override func configureView() {
        super.configureView()
        setupUI()
    }
}

// MARK: - Custom methods
extension PerDayView {
    
    private func setupUI() {
        registerCell()
    }
    private func registerCell() {
        perDayTableView.register(UINib(nibName: "PerDayTableViewCell", bundle: nil), forCellReuseIdentifier: "PerDayTableViewCell")
        perDayTableView.delegate = self
        perDayTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PerDayView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listPerDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PerDayTableViewCell", for: indexPath) as? PerDayTableViewCell else
        { return UITableViewCell() }
        cell.configurePerDay(data: listPerDay[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36
    }
}

