//
//  KeyedDecodingContainer+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

extension KeyedDecodingContainer {
    func decode<T: Decodable>(_ key: Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }

    func decode(_ key: Key, using formatter: DateFormatter) throws -> Date {
        let rawValue = try self.decode(String.self, forKey: key)
        guard let date = formatter.date(from: rawValue) else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Date string does not match format expected by formatter."
            )
        }
        return date
    }
}
