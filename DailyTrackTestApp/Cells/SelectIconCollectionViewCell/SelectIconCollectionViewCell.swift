//
//  SelectIconCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import UIKit

class SelectIconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var themeIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureSelectIcon(model: SelectIconModel) {
        themeIconImage.image = model.IconImage
    }
}
