

import Foundation
import UIKit

class ConnectedArcsView: UIView {
    
    public var segmentDegrees: [CGFloat] = [] {
        didSet {
            var n: Int = 0
            if let subs = layer.sublayers {
                n = subs.count
                if n > segmentDegrees.count {
                    // if we already have sublayers,
                    //  remove any extras
                    for _ in 0..<n - segmentDegrees.count {
                        subs.last?.removeFromSuperlayer()
                    }
                }
            }
            // add sublayers if needed
            while n <  segmentDegrees.count {
                let l = CAShapeLayer()
                l.fillColor = UIColor.clear.cgColor
                layer.addSublayer(l)
                n += 1
            }
            setNeedsLayout()
        }
    }
    
    // segment colors default: [.red, .green, .blue]
    public var segmentColors: [UIColor] = [.red, .green, .blue] { didSet { setNeedsLayout() } }
    
    // line width default: 12
    public var lineWidth: CGFloat = 12 { didSet { setNeedsLayout() } }
    
    // line cap default: .round
    public var lineCap: CAShapeLayerLineCap = .round  { didSet { setNeedsLayout() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let subs = layer.sublayers else { return }
        
        let radius = (bounds.size.width - lineWidth) * 0.5
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // if lineCap == .round
        //  calculate delta for start and end angles
        let delta: CGFloat = lineCap == .round ? asin(lineWidth * 0.45 / radius) : 0.0
        
        // calculate start angle so the "gap" is centered at the bottom
        let totalDegrees: CGFloat = segmentDegrees.reduce(0.0, +)
        var startDegrees: CGFloat = 90.0 + (360.0 - totalDegrees) * 0.5
        
        for i in 0..<segmentDegrees.count {
            let endDegrees = startDegrees + segmentDegrees[i]
            
            guard let shape = subs[i] as? CAShapeLayer else { continue }
            
            shape.lineWidth = lineWidth
            shape.lineCap = lineCap
            shape.strokeColor = segmentColors[i % segmentColors.count].cgColor
            
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: startDegrees.radians + delta,
                                    endAngle: endDegrees.radians - delta,
                                    clockwise: true)
            
            shape.path = path.cgPath
            
            startDegrees += segmentDegrees[i]
        }
        
    }

}

extension CGFloat {
    var degrees: CGFloat {
        return self * CGFloat(180) / .pi
    }
    var radians: CGFloat {
        return self * .pi / 180.0
    }
}
