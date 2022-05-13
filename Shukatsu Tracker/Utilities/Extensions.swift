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

        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        alpha = 0.75
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
//            self.alpha = 1.0
        }
    }
}


extension UIButton {
    func handleTap(gestureRecognizer: UIGestureRecognizer) {

        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }
}

extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
