//
//  Double+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import Foundation

extension Double {
    /// Gives the number with 1 digit after decimal
    var roundedTo1Decimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp

        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
