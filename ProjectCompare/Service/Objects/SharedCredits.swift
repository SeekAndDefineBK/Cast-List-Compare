//
//  SharedCredits.swift
//  ProjectCompare
//
//  Created by bk on 6/27/24.
//

import Foundation

/// Convenience structure to store shared details between person1 and person2
/// This makes UI work easier because all of the properties needed are constructed here
struct SharedCreditsContainer {
    var person1: Person
    var person2: Person
    
    var person1Credits: [CombinedCredits]
    var person2Credits: [CombinedCredits]
    
    var sharedCredits: [SharedCredit] {
        // Create array of ID's from person 1
        let person1IDs = person1Credits.map({$0.id})
        
        // Create array of ID's from person 2
        let person2IDs = person2Credits.map({$0.id})
        
        // Find intersection of the two arrays
        let intersection = person1IDs.intersection(from: person2IDs)
        
        // Create SharedCredit objects with array of intersections
        return intersection.compactMap { id in
            // Find person1 credit details for ID
            let person1Details = person1Credits.first(where: {$0.id == id})
            
            // Find person2 credit details for ID
            let person2Details = person2Credits.first(where: {$0.id == id})
            
            if let person1Details = person1Details, let person2Details = person2Details {
                // Define person1 roles/responsibilities
                let person1Role = definePersonRole(credit: person1Details)
                
                // Define person2 roles/responsibilities
                let person2Role = definePersonRole(credit: person2Details)
                
                // TV Shows use name instead of Title. Check if production is a TV show and then use the correct property
                var title: String? {
                    switch person1Details.mediaType {
                    case .tv:
                        return person1Details.name
                    case .movie:
                        return person1Details.title
                    case .unknown:
                        return "Unknown"
                    }
                }
                
                // TV Shows use first_air_date instead of release_date. Check if production is a TV show and then use the correct property
                var date: Date? {
                    switch person1Details.mediaType {
                    case .tv:
                        return person1Details.firstAirDate
                    case .movie:
                        return person1Details.releaseDate
                    case .unknown:
                        return nil
                    }
                }
                
                // Create SharedCredit with person1 and person2 details
                return SharedCredit(
                    id: id,
                    title: title ?? "Unknown",
                    mediaType: person1Details.mediaType,
                    poster_path: person1Details.poster_path,
                    releaseDate: date,
                    person1: person1,
                    person2: person2,
                    person1Role: person1Role,
                    person2Role: person2Role
                )
            } else {
                return nil
            }
        }
    }
    
    // Movies are split because UI will display these in different List Section
    var movieCredits: [SharedCredit] {
        let filtered = sharedCredits.filter({$0.mediaType == .movie})
        
        return filtered.sorted(by: {$0.releaseDate ?? .distantPast > $1.releaseDate ?? .distantPast})
    }
    
    // TV is split because UI will display these in different List Section
    var tvCredits: [SharedCredit] {
        let filtered = sharedCredits.filter({$0.mediaType == .tv})
        
        return filtered.sorted(by: {$0.releaseDate ?? .distantPast > $1.releaseDate ?? .distantPast})
    }
    
    // Convenience string constructor for Person Role
    func definePersonRole(credit: CombinedCredits) -> String {
        let character = credit.character
        let department = credit.department
        let job = credit.job
        
        return "\(character ?? "") \(department ?? "") \(job ?? "")"
    }
}

/// Container to store relevant shared detail between person1 and person2
struct SharedCredit: Identifiable {
    var id: Int
    var title: String
    var mediaType: MediaType
    var poster_path: String?
    var releaseDate: Date?
    
    var person1: Person
    var person2: Person
    
    var person1Role: String
    var person2Role: String
}
