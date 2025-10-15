//
//  NetworkCacheManager.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import Foundation

class NetworkCacheManager {
    init() {
        configureCache()
    }

    ///
    /// Setup the network cache for the app
    ///
    func configureCache() {
        let memoryCapacity = 50 * 1024 * 1024  // 50 MB
        let diskCapacity = 100 * 1024 * 1024   // 100 MB

        URLCache.shared = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            directory: nil
        )
    }
}
