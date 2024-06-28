//
//  TMDBAPI-Person.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

extension TMDBAPI {
    // MARK: Person Search and Decoding
    
    /// Search TMDB API for a person with a user generated query
    /// - Parameters:
    ///   - query: String. The text the user types in.
    ///   - pageNumber: Optional Int. Allows you to paginate through API results
    /// - Returns: Optional Array of Person
    func searchForPerson(with query: String, pageNumber: Int = 1) async -> [Person]? {
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
    
    /// Converts Data object to an Array of Person
    /// - Parameter data: Data received from cache or API Call
    /// - Returns: Array of Person
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
            
    // MARK: Get Person Credits
    func getCredits(for person: Person) async -> [CombinedCredits]? {
        // fetch credits from TMDB
        let creditsJSON = await fetchCredits(for: person)
        
        // merge cast and crew list
        
        return (creditsJSON?.cast ?? []) + (creditsJSON?.crew ?? [])
    }
    
    
    /// Call TMDB API to get credits with a given Person
    /// - Parameter person: Person. The object you want to find credits for.
    /// - Returns: CombinedCreditsJSON. An object that contains all credits for this person
    private func fetchCredits(for person: Person) async -> CombinedCreditsJSON? {
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
    
    
    /// Converts Data object to optional CombinedCreditsJSON object
    /// - Parameter data: Data received from cache or API Call
    /// - Returns: Optional CombinedCreditsJSON object
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
    

}
