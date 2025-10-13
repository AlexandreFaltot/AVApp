//
//  UIFont+Poppins.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

extension UIFont {
    static func boldPoppinsFont(ofSize size: CGFloat) -> UIFont? { UIFont(name: "Poppins-Bold", size: size) }
    static func lightPoppinsFont(ofSize size: CGFloat) -> UIFont? { UIFont(name: "Poppins-Light", size: size) }
    static func mediumPoppinsFont(ofSize size: CGFloat) -> UIFont? { UIFont(name: "Poppins-Medium", size: size) }
    static func poppinsFont(ofSize size: CGFloat) -> UIFont? { UIFont(name: "Poppins-Regular", size: size) }
    static func semiBoldPoppinsFont(ofSize size: CGFloat) -> UIFont? { UIFont(name: "Poppins-SemiBold", size: size) }
}
