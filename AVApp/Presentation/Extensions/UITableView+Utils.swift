//
//  UITableView+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }

    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}
