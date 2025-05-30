//
//  UIImage.swift
//  sothuchi
//
//  Created by Duy Khanh on 15/8/24.
//

import Foundation
import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
