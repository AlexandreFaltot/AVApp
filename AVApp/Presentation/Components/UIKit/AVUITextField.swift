//
//  AVUITextField.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

import UIKit

@IBDesignable
class AVUIFieldButton: UIButton {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        setupView()
    }

    private let innerShadowLayer: CALayer = CALayer()

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

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutInnerShadow()
    }

    func layoutInnerShadow() {
        innerShadowLayer.frame = bounds

        // Shadow path
        let path = UIBezierPath(rect: innerShadowLayer.bounds.insetBy(dx: -12, dy: -12))
        let cutout = UIBezierPath(rect: innerShadowLayer.bounds).reversing()
        path.append(cutout)
        innerShadowLayer.shadowPath = path.cgPath
        innerShadowLayer.masksToBounds = true

        // Shadow properties
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
