//
//  Preview.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

#if DEBUG
import SwiftUI

// MARK: - Errors
enum PreviewError: Error {
    case sample
}

// MARK: - UIViewControllerRepresentable
struct UIViewControllerPreview: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    // MARK: Properties
    let controller: UIViewController

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIViewController {
        controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // no-op
    }
}

struct UIViewPreview: UIViewRepresentable {
    typealias UIViewType = UIView

    let view: UIView

    func makeUIView(context: Context) -> UIView {
        view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // no-op
    }
}
#endif
