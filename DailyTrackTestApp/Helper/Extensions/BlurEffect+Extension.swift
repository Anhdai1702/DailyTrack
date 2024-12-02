//
//  BlurEffect+Extension.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import UIKit

class BlurManager {
    static let shared = BlurManager()
    
    private init() {}
    
    func applyBlurEffect(to view: UIView, withStyle style: UIBlurEffect.Style = .light, additionalViews: [UIView] = []) {
        if let existingBlurView = view.subviews.first(where: { $0 is UIVisualEffectView }) {
            existingBlurView.removeFromSuperview()
        }
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        for subview in additionalViews {
            view.addSubview(subview)
        }
    }
}
