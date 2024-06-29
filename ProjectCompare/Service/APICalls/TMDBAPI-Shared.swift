//
//  TMDBAPI-Shared.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import Foundation

extension TMDBAPI {
    // MARK: Errors
    // Custom errors to throw related to TMDB
    enum TMDBAPIError: Error {
        case badURL(String)
    }
    
    /// Shared method to perform api request that checks cache first.
    /// - Parameter urlString: String value of the url you intend call
    /// - Returns: Data which will be then need to be decoded
    func performAPICall(with urlString: String) async throws -> Data {
        // if the url is bad, fail silently
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            throw TMDBAPIError.badURL(urlString)
        }
        
        // build the url request to check against cache
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        
        // First Check if cachedData contains this request
        if let cachedData = cache.cachedResponse(for: request)?.data {
            // if available return cached data
            return cachedData
        } else {
            // otherwise make a new api call
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
    }
    
    func getImageURL(with path: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
