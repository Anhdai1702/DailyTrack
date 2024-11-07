//
//  NoCopyPasteTextView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import Foundation
import UIKit

class NoCopyPasteTextView: UITextView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
