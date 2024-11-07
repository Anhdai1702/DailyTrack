//
//  TextFiled+Extension.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    // Padding property can be changed
    var leftPadding: CGFloat = 0
    
    // Adjust text position in normal state
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftPadding, dy: 0)
    }
    
    // Adjust text position while editing
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftPadding, dy: 0)
    }
}
