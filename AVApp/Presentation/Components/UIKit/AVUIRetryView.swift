//
//  AVUIRetryView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import UIKit

@IBDesignable
class AVUIRetryView: AVNibView {
    // MARK: - IB properties
    @IBInspectable var localizedErrorMessageKey: String? {
        get { errorMessageLabel.localizedKey }
        set { errorMessageLabel.localizedKey = newValue }
    }

    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorMessageLabel: AVUILabel!

    // MARK: - Public properties

    var onAskForRetry: (() -> Void)?

    // MARK: - Lifecycle

    override func setupView() {
        super.setupView()
        retryButton.setTitle(String(localized: .retry), for: .normal)
    }

    @IBAction func onRetry(_ sender: UIButton) {
        onAskForRetry?()
    }
}
