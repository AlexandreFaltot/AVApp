//
//  UITableView+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit

extension UITableView {
    ///
    /// Dequeue a reusable cell of the given type, registered with its type description
    ///
    /// - Parameter type: The type of the cell
    /// - Returns: A dequeued cell if found
    ///
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }

    ///
    /// Registers a cell to be reused with the given type. The reuse identifier will be the type description of the cell
    ///
    /// - Parameter type: The type of the cell
    ///
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}
