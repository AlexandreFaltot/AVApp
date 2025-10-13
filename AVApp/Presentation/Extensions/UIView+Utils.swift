//
//  UIView+Inspectable.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

// MARK: - Inspectables
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable var maskToBounds: Bool {
        get { layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get { layer.borderColor.map { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
}

// MARK: - Utils
extension UIView {
    func addConstrainedSubview(_ view: UIView, with insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
        ])
    }
}
