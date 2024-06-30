//
//  TMDBAPIError.swift
//  ProjectCompare
//
//  Created by bk on 6/29/24.
//

import Foundation

// MARK: Errors
// Custom errors to throw related to TMDB
enum TMDBAPIError: Error {
    case badURL(String)
    case badAPIKey(String)
    case statusConversionFailed(String)
}
