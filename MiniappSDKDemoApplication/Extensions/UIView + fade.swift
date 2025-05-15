//
//  UIView + fade.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit

extension UIView {
    func fadeTransitionAnimation(duration: TimeInterval, block: () -> Void) {
        let a = CATransition()
        a.type = .fade
        a.fillMode = .forwards
        a.duration = duration
        block()
        layer.add(a, forKey: "fadeTransitionAnimation")
    }
}
