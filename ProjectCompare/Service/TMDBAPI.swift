//
//  TMDB_API_Protocol.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

class TMDBAPI {
    // Collect key
    let key = TMDBAPIKey.key
    
    // Store a cache of URL Responses to prevent pinging server too much
    var cache = URLCache.shared
    
    // Singleton instance of TMDBAPI
    static let shared = TMDBAPI()
    
    init() {
        // set storage and memory limits for cache
        cache.diskCapacity = 100 * 1024 * 1024 //100mb Storage
        cache.memoryCapacity = 100 * 1024 * 1024 //100mb Memory
    }
}
