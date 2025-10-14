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

    func configureCache() {
        // Configure URLCache with custom memory and disk capacity
        let memoryCapacity = 50 * 1024 * 1024  // 50 MB
        let diskCapacity = 100 * 1024 * 1024   // 100 MB

        URLCache.shared = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            directory: nil
        )
    }

    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }

    func getCacheSize() -> (memory: Int, disk: Int) {
        return (
            memory: URLCache.shared.currentMemoryUsage,
            disk: URLCache.shared.currentDiskUsage
        )
    }
}
