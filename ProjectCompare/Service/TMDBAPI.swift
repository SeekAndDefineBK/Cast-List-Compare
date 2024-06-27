//
//  TMDB_API_Protocol.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

class TMDBAPI: ObservableObject {
    // Collect key
    let key = TMDBAPIKey.key
    
    // Store a cache of URL Responses to prevent pinging server too much
    @Published var cache = URLCache.shared
        
    init() {
        // set storage and memory limits for cache
        cache.diskCapacity = 100 * 1024 * 1024 //100mb Storage
        cache.memoryCapacity = 100 * 1024 * 1024 //100mb Memory
    }
}
