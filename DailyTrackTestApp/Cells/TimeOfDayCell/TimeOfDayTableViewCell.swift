//
//  TimeOfDayTableViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 29/11/24.
//

import UIKit

class TimeOfDayTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkMarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureTimeOfDay(model: TimeOfDayModel) {
        titleLabel.text = model.titleLabel
    }
    
    func toggleSelection(isSelected: Bool) {
        checkMarkImage.isHidden = !isSelected
    }
}
