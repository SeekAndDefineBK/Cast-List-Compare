//
//  ProjectCompareTests.swift
//  ProjectCompareTests
//
//  Created by bk on 6/29/24.
//

import XCTest
@testable import ProjectCompare

class BaseTestCase: XCTestCase {
    // Shared Assets
    var tmdb: TMDBAPI!
    
    override func setUpWithError() throws {
        tmdb = TMDBAPI.shared
    }
    
    // MARK: Expected Results
    let sethRogen = Person(
        id: 19274,
        name: "Seth Rogen",
        popularity: 29.847, // Popularity will not be tested as it can change
        profile_path: "/2dPFskUtoiG0xafsSEGl9Oz4teA.jpg" // This can change, but it should also be tested
    )
    
    let jamesFranco = Person(
        id: 17051,
        name: "James Franco",
        popularity: 30.722
    )
}

