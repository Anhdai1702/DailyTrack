//
//  NewHabitCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 13/11/24.
//

import UIKit

class NewHabitCollectionViewCell: UICollectionViewCell {

    //MARK: - 0utlets
    @IBOutlet private weak var titleNewHabitLabel: UILabel!
    @IBOutlet private weak var newHabitImage: UIImageView!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureNewHabit(model: NewHabitModel) {
        titleNewHabitLabel.text = model.titleNewHabit
        newHabitImage.image = model.newHabitImage
    }

}
