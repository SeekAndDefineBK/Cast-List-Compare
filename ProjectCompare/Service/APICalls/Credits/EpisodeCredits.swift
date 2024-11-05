//
//  EpisodeCredits.swift
//  ProjectCompare
//
//  Created by Brett Koster on 9/28/24.
//

import Foundation

extension TMDBAPI {
    func getCreditDetails(person1Credits: CombinedCredits, person2Credits: CombinedCredits) -> String {
        // initialize api call for person 1
        let person1url = "https://api.themoviedb.org/3/credit/\(person1Credits.credit_id)"
        
        // perform call
        
        // convert data to credit details object
        
        
        // initialize api call for person 2
        let person2url = "https://api.themoviedb.org/3/credit/\(person2Credits.credit_id)"
        
        // perform call
        
        // convert data to credit details object
        
        
        // Compare air_date of episodes from person 1 and person 2.
        
        // If there are no overlaps, they did not appear on the same episode
        
        
        return ""
    }
}
