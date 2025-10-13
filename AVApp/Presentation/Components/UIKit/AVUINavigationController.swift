//
//  UINavigationController+Gesture.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import UIKit

class AVUINavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .avPrimary
    }
}

extension AVUINavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
