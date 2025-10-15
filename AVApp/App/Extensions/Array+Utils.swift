//
//  Array+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit
import Combine
import SwiftUI

extension Array {
    ///
    /// Gives the element at the given index if it exists.
    /// Otherwise, gives `nil`
    ///
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
