//
//  AVUITextField.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

import UIKit

@IBDesignable
class AVUIFieldButton: UIButton {
    // MARK: - IBInspectable properties
    @IBInspectable var localizedTitleKey: String = "" {
        didSet {
            setTitle(NSLocalizedString(localizedTitleKey, comment: ""), for: .normal)
        }
    }

    @IBInspectable var leadingImage: UIImage? {
        didSet {
            setImage(leadingImage, for: .normal)
        }
    }

    // MARK: - Private properties

    private let innerShadowLayer: CALayer = CALayer()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutInnerShadow()
    }

    // MARK: - Public methods

    func setupView() {
        tintColor = .avWhite
        contentHorizontalAlignment = .leading
        backgroundColor = .avDark
        layer.cornerRadius = 12.0
        layer.masksToBounds = true
        layer.addSublayer(innerShadowLayer)

        configuration = UIButton.Configuration.plain()
        configuration?.imagePadding = 20.0
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0)
    }

    // MARK: - Private methdos

    ///
    /// Layout the inner shadow of the view
    ///
    private func layoutInnerShadow() {
        innerShadowLayer.frame = bounds

        // Create the shadow path. It should be thick enough so a shadow is displayed
        let path = UIBezierPath(rect: innerShadowLayer.bounds.insetBy(dx: -12, dy: -12))
        let cutout = UIBezierPath(rect: innerShadowLayer.bounds).reversing()
        path.append(cutout)
        innerShadowLayer.shadowPath = path.cgPath
        innerShadowLayer.masksToBounds = true

        // Set the shadow properties
        innerShadowLayer.shadowColor = UIColor.black.cgColor
        innerShadowLayer.shadowOffset = CGSize.init(width: 0, height: 4)
        innerShadowLayer.shadowOpacity = 0.25
        innerShadowLayer.shadowRadius = 4
    }
}

#if DEBUG
import SwiftUI

#Preview {
    VStack {
        Spacer()
        UIViewPreview(view: {
            let view = AVUIFieldButton(type: .custom)
            view.leadingImage = .avSearch
            view.localizedTitleKey = "search_movie"
            return view
        }())
        .frame(height: 48)
        UIViewPreview(view: {
            let view = AVUIFieldButton(type: .custom)
            view.localizedTitleKey = "search_movie"
            return view
        }())
        .frame(height: 48)
        Spacer()
    }
    .background(Color.avPrimary)

}
#endif
