//
//  UIViewController+Storyboard.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit

extension UIViewController {
    ///
    /// Gives an instance of the view controller by inflating its view from
    /// a dedicated storyboard
    ///
    class func instanceFromStoryboard() -> Self? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? Self
    }
}
