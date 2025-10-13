//
//  UINavigationController+Gesture.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import UIKit
import SwiftUI

class AVUIHostingViewController<Content: View>: UIHostingController<Content> {
    override init(rootView: Content) {
        super.init(rootView: rootView)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        view.backgroundColor = .avPrimary
    }
}
