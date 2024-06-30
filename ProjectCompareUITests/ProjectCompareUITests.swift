//
//  ProjectCompareUITests.swift
//  ProjectCompareUITests
//
//  Created by bk on 6/29/24.
//

import XCTest

final class ProjectCompareUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // Shared app initialization to speed up testing
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    func testCompareButtonIsDisabledByDefault() throws {
        // Compare button should be disabled by default to prevent a comparison between 1 and 0 people
        XCTAssertTrue(!app.buttons["Compare"].isEnabled)
    }
    
    func testUISearchWorks() throws {
        // Perform search with reusable function
        searchForPerson(name: "Seth Rogen")
        
        // Validate Seth is on screen and the clear button exists
        XCTAssertTrue(app.staticTexts["Seth Rogen"].exists)
        XCTAssertTrue(app.buttons["Clear"].exists)
    }
    
    func testCompareWorks() throws {
        // Search for Seth Rogen
        searchForPerson(name: "Seth Rogen")
        
        // Validate he appears on screen
        XCTAssertTrue(app.staticTexts["Seth Rogen"].exists)
        
        // Compare should still be disabled
        XCTAssertTrue(!app.buttons["Compare"].isEnabled)
        
        // Search for James Franco
        searchForPerson(name: "James Franco")
        
        // validate he appears on screen
        XCTAssertTrue(app.staticTexts["James Franco"].exists)
        
        // Compare button should now be available
        XCTAssertTrue(app.buttons["Compare"].isEnabled)
        
        // Open Comparison
        app.buttons["Compare"].tap()
        
        // Validate that summary of comparison exists
        XCTAssertTrue(app.staticTexts["Seth Rogen and James Franco have been in 31 productions together"].exists)
    }
    
    /// These are the reusable steps to search for a person
    /// - Parameter name: String value of the search query
    func searchForPerson(name: String) {
        app.buttons["Search for a Person"].firstMatch.tap()
        app.textFields["Enter Person Name"].tap()
        app.textFields["Enter Person Name"].typeText(name)
        app.buttons["searchForPerson"].tap()
        app.buttons[name].tap()
    }
}
