//
//  RepeatTableViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 24/11/24.
//

import UIKit

class RepeatTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkMarkImage: UIImageView!
    @IBOutlet weak var repeatView: UIView!
    private var originalBackgroundColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    private func setupView() {
        contentView.backgroundColor = .clear
        
    }
    
    func configureRepeat(model: RepeatModel) {
        titleLabel.text = model.dayLabel
    }
    
    func toggleSelection(isSelected: Bool) {
        checkMarkImage.isHidden = !isSelected
    }
}
