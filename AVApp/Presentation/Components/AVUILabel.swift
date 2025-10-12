//
//  AVUILabel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//


import UIKit
import Combine
import SwiftUI

@IBDesignable
class AVUILabel: UILabel {
    @IBInspectable var style: Int = 1{
        didSet {
            setStyle(style)
        }
    }
    @IBInspectable var localizedKey: String? {
        didSet {
            setLocalizedKey(localizedKey)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    func setupView() {
        setStyle(style)
        setLocalizedKey(localizedKey)
        self.textColor = UIColor.white
    }

    func setStyle(_ style: Int) {
        let style = TextStyle(rawValue: style)
        font = style?.font ?? .systemFont(ofSize: 16)
    }

    func setLocalizedKey(_ key: String?) {
        text = localizedKey.map { NSLocalizedString($0, comment: "") }
    }
}
