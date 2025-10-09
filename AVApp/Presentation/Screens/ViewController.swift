//
//  ViewController.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIHostingController(rootView: DetailScreenView())
    }
}



#if DEBUG
import SwiftUI

#Preview("Error preview") {
    UIViewControllerPreview(controller: ViewController())
}

#Preview("Empty list preview") {
    UIViewControllerPreview(controller: ViewController())
}

#Preview("Normal preview") {
    UIViewControllerPreview(controller: ViewController())
}
#endif
