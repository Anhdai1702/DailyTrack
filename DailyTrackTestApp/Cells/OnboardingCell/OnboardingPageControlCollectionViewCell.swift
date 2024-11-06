//
//  OnboardingPageControlCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import UIKit

class OnboardingPageControlCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var pageControlView: UIView!
    
    struct ConstantsOnboardingPageControl {
        static let selectedColor = UIColor(hex: "#1640D6")
        static let unselectedColor = UIColor(hex: "#8A8E9E")
        static let selectedRadius: CGFloat = 3.3
        static let unselectedRadius: CGFloat = 3
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView(isSelect: Bool) {
        pageControlView.border(radius: isSelect ? ConstantsOnboardingPageControl.selectedRadius: ConstantsOnboardingPageControl.unselectedRadius)
        pageControlView.backgroundColor = isSelect ?  ConstantsOnboardingPageControl.selectedColor: ConstantsOnboardingPageControl.unselectedColor
    }
}
