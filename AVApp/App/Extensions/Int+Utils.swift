//
//  Int+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

extension Int {
    func asHourFormat() -> String {
        let hours = self / 60
        let minutes = self % 60

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad

        let components = DateComponents(hour: hours, minute: minutes)
        return formatter.string(from: components) ?? "\(hours)h\(minutes)"
    }
}
