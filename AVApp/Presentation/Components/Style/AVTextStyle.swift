//
//  TextStyle.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

enum AVTextStyle: Int {
    /// bold poppins 28.0
    case header1
    /// semi bold poppins 22.0
    case header2
    /// medium poppins 18.0
    case header3
    /// regular poppins 16.0
    case paragraph
    /// medium poppins 16.0
    case paragraphBold
    /// regular poppins 14.0
    case smallParagraph
    /// medium poppins 14.0
    case smallParagraphBold
    /// light poppins 14.0
    case caption

    var font: UIFont {
        let font: UIFont? = switch self {
        case .header1: .boldPoppinsFont(ofSize: fontSize)
        case .header2: .semiBoldPoppinsFont(ofSize: fontSize)
        case .header3: .mediumPoppinsFont(ofSize: fontSize)
        case .paragraph, .smallParagraph: .poppinsFont(ofSize: fontSize)
        case .paragraphBold, .smallParagraphBold: .mediumPoppinsFont(ofSize: fontSize)
        case .caption: .lightPoppinsFont(ofSize: fontSize)
        }

        return font ?? .systemFont(ofSize: fontSize)
    }

    var fontSize: CGFloat {
        switch self {
        case .header1: 28
        case .header2: 22
        case .header3: 18
        case .paragraph, .paragraphBold: 16
        case .caption, .smallParagraph, .smallParagraphBold: 14
        }
    }
}
