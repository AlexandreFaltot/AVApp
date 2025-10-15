//
//  KeyedDecodingContainer+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

extension KeyedDecodingContainer {
    ///
    /// Decodes the key, inferring the type to decode
    ///
    /// - Parameter key: The key from which to decode value
    /// - Returns: The decoded value
    ///
    func decode<T: Decodable>(_ key: Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    ///
    /// Decodes a ``String`` key and gives the ``Date`` object
    /// represented by the string, using the given formatter
    ///
    /// - Parameters:
    ///   - key: The key from which to decode value
    ///   - formatter:The ``DateFormatter`` used to transform the string contained by the key
    ///
    /// - Returns: A ``Date`` representation of the string
    ///
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
