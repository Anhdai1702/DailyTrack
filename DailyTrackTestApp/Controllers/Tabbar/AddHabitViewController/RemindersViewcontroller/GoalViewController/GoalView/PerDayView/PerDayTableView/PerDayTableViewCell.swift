//
//  PerDayTableViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 29/11/24.
//

import UIKit

class PerDayTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurePerDay(data: String) {
        titleLabel.text = data
    }
}
