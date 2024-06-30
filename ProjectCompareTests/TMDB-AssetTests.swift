//
//  TMDB-AssetTests.swift
//  ProjectCompareTests
//
//  Created by bk on 6/29/24.
//

import XCTest
import UIKit // used to validate TMDBLogo exists
@testable import ProjectCompare

final class TMDB_AssetTests: BaseTestCase {
    // Test that API Key exists
    func testAPIKeyExists() throws {
        XCTAssertNotNil(TMDBAPI.shared.key)
    }
    
    // Test that API Key works
    func testAPIKeyWorks() async throws {
        let keyTest = try await tmdb.validateKey()
        XCTAssertTrue(keyTest.success)
    }
    
    // Test TMDB logo exists
    func testTMDBLogoExists() async throws {
        XCTAssertNotNil(UIImage(named: "TMDBLogo"))
    }
}
