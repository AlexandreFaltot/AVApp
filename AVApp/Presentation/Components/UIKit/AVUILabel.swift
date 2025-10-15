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
    // MARK: - IB Properties
    @IBInspectable var style: Int = 1 {
        didSet {
            setStyle(style)
        }
    }
    @IBInspectable var localizedKey: String? {
        didSet {
            setLocalizedKey(localizedKey)
        }
    }

    // MARK: - Lifecycle

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

    // MARK: - Public methods

    func setupView() {
        setStyle(style)
        setLocalizedKey(localizedKey)
        self.textColor = UIColor.white
    }

    // MARK: - Private methods
    
    ///
    /// Sets the label style
    ///
    /// - Parameter style: The style to use for the label
    ///
    private func setStyle(_ style: Int) {
        guard let style = AVTextStyle(rawValue: style) else {
            return
        }
        font = style.font
    }

    ///
    /// Sets the label text based on the given localized key
    ///
    /// - Parameter key: The key used for localization
    ///
    private func setLocalizedKey(_ key: String?) {
        text = localizedKey.map { NSLocalizedString($0, comment: "") }
    }
}
