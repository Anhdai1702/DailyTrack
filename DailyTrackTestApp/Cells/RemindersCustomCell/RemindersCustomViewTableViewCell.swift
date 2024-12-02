//
//  RemindersCustomViewTableViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import UIKit

class RemindersCustomViewTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var themeColorImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var periodOfTimeLabel: UILabel!
    @IBOutlet private weak var viewColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewColor.backgroundColor = Constants.color15151C
    }
    
    func configureReminders(model: CreateNewHabitModel) {
        themeColorImage.image = model.themePhotoImage
        titleLabel.text = model.titleLabel
        periodOfTimeLabel.text = model.periodOfTimeLabel
        viewColor.backgroundColor = model.viewColor
    }
    
    func applyCornerRadius(for indexPath: IndexPath, itemCount: Int, radius: CGFloat) {
        // Define the corners to be rounded
           var corners: UIRectCorner = []
           if indexPath.row == 0 { // First cell in each section
               corners.insert(.topLeft)
               corners.insert(.topRight)
           }
           if indexPath.row == itemCount - 1 { // Last cell in each section
               corners.insert(.bottomLeft)
               corners.insert(.bottomRight)
           }
        // Apply rounded corners to cell
           let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
           let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           self.layer.mask = mask
       }
}
