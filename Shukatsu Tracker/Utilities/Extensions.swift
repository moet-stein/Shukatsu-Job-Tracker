//
//  Extensions.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.05.22.
//

import Foundation
import UIKit

extension UIImageView {
    func handleTap(gestureRecognizer: UIGestureRecognizer) {

        transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//        alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
//            self.alpha = 1.0
        }
    }
}
