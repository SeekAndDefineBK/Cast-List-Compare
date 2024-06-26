//
//  PersonSearchResult.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

struct PersonSearch: Codable {
    let results: [Person]
    let page: Int // The current page that has been searched
    let total_pages: Int // Total number of pages available from search query
    let total_results: Int // Total number of people available from search query
}
