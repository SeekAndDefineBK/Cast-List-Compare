//
//  TMDBAPI-Person.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

extension TMDBAPI {
    // MARK: Search with Query
    func searchForPerson(with query: String, pageNumber: Int) async -> [Person]? {
        // convert user query into string value compatible with url scheme
        let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // build url string
        let urlString = "https://api.themoviedb.org/3/search/person?api_key=\(key)&language=en-US&query=\(urlQuery ?? "")&page=\(pageNumber)"
        
        do {
            // use urlString to perform api call
            let data = try await performAPICall(with: urlString)
            
            // data that returns is either cached or a new request
            return convertDataToPersonArray(with: data)
        } catch {
            print("Failed to search for a new person \(error.localizedDescription)")
            return nil
        }
    }
            
    // MARK: Get Person Credits
    func getCredits(for person: Person) async -> CombinedCreditsJSON? {
        // build url string with Person ID
        let urlString = "https://api.themoviedb.org/3/person/\(person.id)/combined_credits?api_key=\(key)"
        
        do {
            // use urlString to perform api call
            let data = try await performAPICall(with: urlString)
            
            return decodeCombinedCredits(with: data)
        } catch {
            print("Failed to collect combined credits for \(person.name). ID: \(person.id). urlString: \(urlString)")
            return nil
        }
    }
    
    // MARK:
    private func decodeCombinedCredits(with data: Data) -> CombinedCreditsJSON? {
        // Initialize Decoder
        let decoder = JSONDecoder()
        
        do {
            // Convert data to CombinedCreditsJSON
            let results = try decoder.decode(CombinedCreditsJSON.self, from: data)
            
            return results
        } catch {
            // Print raw error if this occurs and return nothing
            print("Failed to convert data to CombinedCreditsJSON. Error \(error)")
            return nil
        }
    }
    
    //MARK: Convert Data to Person Array
    private func convertDataToPersonArray(with data: Data) -> [Person] {
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
            print("Failed to convert data to Person array. Error: \(error)")
            return []
        }
    }
}
