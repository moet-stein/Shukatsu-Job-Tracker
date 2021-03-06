//
//  Extensions.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 11.05.22.
//

import Foundation
import UIKit

public extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}


public extension UIView {
    
    func collectionViewCellTapped() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
        UIView.animate(withDuration: 0.1, delay: 0.3, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func handleTapShortDuration(gestureRecognizer: UIGestureRecognizer) {

        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        alpha = 0.75
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
//            self.alpha = 1.0
        }
    }
    
    func handleTapLongDuration(gestureRecognizer: UIGestureRecognizer) {

        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        alpha = 0.75
        UIView.animate(withDuration: 0.6) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }
    
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
