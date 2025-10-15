//
//  DateFormatter+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

extension DateFormatter {
    
    ///
    /// The ``DateFormatter`` used to decode dates from MovieDB API
    ///
    /// - Returns: a ``DateFormatter`` configured for the API
    ///
    static func movieApiFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    ///
    /// The ``DateFormatter`` used to display dates in the app
    ///
    /// - Returns: a ``DateFormatter`` configured for display
    ///
    static func movieDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
