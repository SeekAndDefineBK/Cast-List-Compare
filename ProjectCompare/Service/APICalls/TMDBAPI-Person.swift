//
//  TMDBAPI-Person.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

extension TMDBAPI {
    // MARK: Search with Query
    func searchForPerson(query: String, pageNumber: Int) async -> [Person]? {
        // convert user query into string value compatible with url scheme
        let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // build url string
        let urlString = "https://api.themoviedb.org/3/search/person?api_key=\(key)&language=en-US&query=\(urlQuery ?? "")&page=\(pageNumber)"
        
        // if the url is bad, fail silently
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return nil
        }
        
        // build the url request to check against cache
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        
        // First Check if cachedData contains this request
        if let cachedDate = cache.cachedResponse(for: request)?.data {
            
            // convered cachedData to Person Array
            return convertDataToPersonArray(cachedDate)
        } else {
            
            // Request is not contained in Cache so create a new API request
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                return convertDataToPersonArray(data)
            } catch {
                print("Failed to search for a new pers \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    // MARK: Search with ID
        
    // MARK: Get Person Credits
    
    // MARK: Convert Data to Person Object
    func convertDataToPerson(_ data: Data) -> Person? {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(Person.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: Convert Data to Person Array
    func convertDataToPersonArray(_ data: Data) -> [Person] {
        // Initialize Decoder
        let decoder = JSONDecoder()
        
        do {
            // TMDB search results returns more than just the Person array
            // decode to PersonSearch struct
            let search = try decoder.decode(PersonSearch.self, from: data)
            
            // Search results are stored in results property of PersonSearch
            return search.results
        } catch {
            // Print raw error if this occurs and return nothing
            print(error)
            return []
        }
    }
}
