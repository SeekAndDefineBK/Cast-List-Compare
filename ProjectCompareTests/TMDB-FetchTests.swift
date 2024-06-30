//
//  TMDB-FetchTests.swift
//  ProjectCompareTests
//
//  Created by bk on 6/29/24.
//

import XCTest
@testable import ProjectCompare

final class TMDB_FetchTests: BaseTestCase {
    // MARK: Search Tests
    func testSearchQueryHasSeth() async throws {
        // given
        let query = "Seth Rogen"
        
        // when
        let results = await tmdb.searchForPerson(with: query)
        
        // then
        // results should not be nil
        XCTAssertNotNil(results)
        
        // MARK: this also validates that Data Converts to Seth Rogen
        let resultsContainSethRogen = results!.contains(where: {$0.id == sethRogen.id})
        
        // results should include Seth Rogen
        XCTAssertTrue(resultsContainSethRogen)
    }
    
    // MARK: Test Credits Exist
    func testCreditsExistForSeth() async throws {
        // given
        // properties already defined in this class and base class
        
        // when
        let results = await tmdb.getCredits(for: sethRogen)
        
        // then
        XCTAssertNotNil(results)
    }
    
    // MARK: Test Get Image
    func testGetImage() async throws {
        //given
        // properties already defined in this class and base class

        // when
        let imageURL = tmdb.getImageURL(with: sethRogen.profile_path ?? "")
        
        // then
        // Validate the url isn't Nil
        XCTAssertNotNil(imageURL)
        
        // validate the status code of the url
        let (_, response) = try await URLSession.shared.data(from: imageURL!)
        
        // Cast response as HTTPURLResponse to capture statusCode in following test
        let httpUrlResponse = response as? HTTPURLResponse
        
        XCTAssertEqual(httpUrlResponse?.statusCode, 200)
    }
}
