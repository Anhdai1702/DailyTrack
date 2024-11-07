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
        static let selectedRadius: CGFloat = 3.3
        static let unselectedRadius: CGFloat = 3
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView(isSelect: Bool) {
        pageControlView.border(radius: isSelect ? ConstantsOnboardingPageControl.selectedRadius: ConstantsOnboardingPageControl.unselectedRadius)
        pageControlView.backgroundColor = isSelect ?  Constants.color1640D6: Constants.color8A8E9E
    }
}
