//
//  AVNibView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//


import UIKit

@IBDesignable
class AVNibView: UIView {
    private(set) lazy var contentView: UIView? = {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))

        return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    private func loadFromNib() {
        guard let contentView else { return }
        addConstrainedSubview(contentView)
        setupView()
    }

    func setupView() {
        backgroundColor = .clear
    }
}
