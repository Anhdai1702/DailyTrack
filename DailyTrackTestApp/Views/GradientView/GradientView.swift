//
//  GradientView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 13/11/24.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyGradient()
    }
    
    private func applyGradient() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the gradient layer to match the view's bounds
        gradientLayer.frame = self.bounds
        
        // Define the gradient colors (start color and end color)
        gradientLayer.colors = [
            Constants.color15151CWithZeroAlpha.cgColor,    // Top color
            Constants.color15151C.cgColor    // Bottom color
        ]
        
        // Set the gradient direction from top to bottom
        gradientLayer.startPoint = CGPoint(x: 0.9, y: 0.0)   // Top center
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)     // Bottom center
        
        // Optionally set the locations for color stops (0 means start, 1 means end)
        gradientLayer.locations = [0.0, 1.0]
        
        // Add the gradient layer to the view
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Ensure the gradient adjusts to view resizing
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
        }
    }
}
