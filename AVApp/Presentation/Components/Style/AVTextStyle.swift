//
//  TextStyle.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

enum AVTextStyle: Int {
    case header1, header2, header3, paragraph, caption

    var font: UIFont? {
        return switch self {
        case .header1: .boldSystemFont(ofSize: 28)
        case .header2: .semiBoldPoppinsFont(ofSize: 22)
        case .header3: .mediumPoppinsFont(ofSize: 18)
        case .paragraph: .poppinsFont(ofSize: 16)
        case .caption: .lightPoppinsFont(ofSize: 14)
        }
    }
}
