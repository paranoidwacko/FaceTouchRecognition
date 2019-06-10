import Foundation
import UIKit

/**
 Public extension for the UIView class to allow sharing behaviour across the project
 - author: Wacko
 - date: 02/07/2019
 */
public extension UIView {
    func Shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func AddSubviews(_ subviews: [UIView]) {
        for item in subviews {
            self.addSubview(item)
        }
    }
}
