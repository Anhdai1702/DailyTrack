//
//  UIView+Extension.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import Foundation
import UIKit

extension UIView {
    func viewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
