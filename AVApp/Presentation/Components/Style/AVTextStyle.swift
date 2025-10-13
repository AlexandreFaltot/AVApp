//
//  TextStyle.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

enum AVTextStyle: Int {
    case header1, header2, header3, paragraph, caption

    var font: UIFont {
        let font: UIFont? = switch self {
        case .header1: .boldPoppinsFont(ofSize: fontSize)
        case .header2: .semiBoldPoppinsFont(ofSize: fontSize)
        case .header3: .mediumPoppinsFont(ofSize: fontSize)
        case .paragraph: .poppinsFont(ofSize: fontSize)
        case .caption: .lightPoppinsFont(ofSize: fontSize)
        }

        return font ?? .systemFont(ofSize: fontSize)
    }

    var fontSize: CGFloat {
        switch self {
        case .header1: 28
        case .header2: 22
        case .header3: 18
        case .paragraph: 16
        case .caption: 14
        }
    }
}
