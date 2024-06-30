//
//  APIKeyValidation.swift
//  ProjectCompare
//
//  Created by bk on 6/29/24.
//

import Foundation

extension TMDBAPI {
    /// Tests that the API key is valid
    /// - Returns: TMDBAPIKeyValidation
    func validateKey() async throws -> TMDBAPIKeyValidation {
        // send key into validation uri
        let urlString = "https://api.themoviedb.org/3/authentication?api_key=\(key)"
        
        // validate the url is not nil
        guard let url = URL(string: urlString) else {
            throw TMDBAPIError.badURL("Bad url: \(urlString)")
        }
        
        // create URLRequest without caching
        let request = URLRequest(url: url)
        
        do {
            // perform api call
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // if successful, attempt to convert data to TMDBAPIKeyValidation object
            return try convertDataToKeyValidation(data)
        } catch {
            // if unnsuccssful, throw badAPIKey error
            throw TMDBAPIError.badAPIKey("Bad API Key: \(urlString)")
        }
    }
    
    /// Converts Data from URLSession into API Validation container
    /// - Parameter data: data from URLSession
    /// - Returns: TMDBAPIKeyValidation object
    private func convertDataToKeyValidation(_ data: Data) throws -> TMDBAPIKeyValidation {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(TMDBAPIKeyValidation.self, from: data)
        } catch {
            throw TMDBAPIError.statusConversionFailed("Failed to decode Data to TMDBAPIKeyValidation")
        }
        
    }
}

// This object collects the response from the key validation end point
// and helps validate success in Unit Tests
struct TMDBAPIKeyValidation: Codable {
    var success: Bool
    var status_code: Int
    var status_message: String
}

