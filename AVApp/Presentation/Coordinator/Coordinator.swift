//
//  Coordinator.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import UIKit

protocol Coordinator: AnyObject {
    // MARK: Properties
    var navigationController: UINavigationController { get }

    // MARK: Methods
    func start()
    func navigateToDetail(movie: AVMovie)
}
