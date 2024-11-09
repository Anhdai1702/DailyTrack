//
//  UIColor.swift
//  sothuchi
//
//  Created by Duy Khanh on 7/8/24.
//

import Foundation
import UIKit

extension UIColor {
  convenience init(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
    let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
    let blue = CGFloat(rgb & 0xFF) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: 1.0)
  }
    
    var hexString: String {
        let components = cgColor.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    convenience init?(hexString: String, alpha: Double) {
        let red, green, blue: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    blue = CGFloat(hexNumber & 0x0000FF) / 255.0
                    
                    self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
                    return
                }
            }
        }
        
        return nil
    }
}


