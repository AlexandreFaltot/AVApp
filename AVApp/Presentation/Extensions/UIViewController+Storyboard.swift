//
//  UIViewController+Storyboard.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit

extension UIViewController {
    class func instanceFromStoryboard() -> Self? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? Self
    }
}
