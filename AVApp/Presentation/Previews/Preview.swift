//
//  Preview.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

#if DEBUG
import SwiftUI

enum PreviewError: Error {
    case sample
}

final class UIViewControllerPreview: UIViewControllerRepresentable {

    private var controller: UIViewController

    init(controller: UIViewController) {
        self.controller = controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Nothing to do
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        return controller
    }
}
#endif
