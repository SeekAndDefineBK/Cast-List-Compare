//
//  SharedCredit-Conversions.swift
//  ProjectCompareTests
//
//  Created by bk on 6/29/24.
//

import XCTest

final class SharedCredit_Conversions: BaseTestCase {

    // MARK: Test Movie Credits Exist
    func testCreditsExist() async throws {
        // given
        let viewModel = await CompareView.CompareViewModel(
            person1: sethRogen,
            person2: jamesFranco
        )
        
        // when
        await viewModel.getCredits()
        let sharedCredits = await viewModel.sharedCredits
        
        // then
        XCTAssertNotNil(sharedCredits)
    }

    func testMovieCreditsAreNotEmpty() async throws {
        // given
        let viewModel = await CompareView.CompareViewModel(
            person1: sethRogen,
            person2: jamesFranco
        )
        
        // when
        await viewModel.getCredits()
        let movieCreditsIsEmpty = await viewModel.sharedCredits?.movieCredits.isEmpty ?? true
        
        // then
        XCTAssertFalse(movieCreditsIsEmpty)
    }
    
    func testTVCreditsAreNotEmpty() async throws {
        // given
        let viewModel = await CompareView.CompareViewModel(
            person1: sethRogen,
            person2: jamesFranco
        )
        
        // when
        await viewModel.getCredits()
        let tvCreditsIsEmpty = await viewModel.sharedCredits?.tvCredits.isEmpty ?? true
        
        // then
        XCTAssertFalse(tvCreditsIsEmpty)
    }
}
