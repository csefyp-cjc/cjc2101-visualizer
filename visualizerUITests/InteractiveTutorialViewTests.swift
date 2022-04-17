//
//  InteractiveTutorialViewTests.swift
//  visualizerUITests
//
//  Created by Andrew Li on 13/2/2022.
//

import XCTest

class InteractiveTutorialViewTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_InteractiveTutorialView_firstLaunch_shouldPopupTutorialOverlay() throws {
        // Given
        
        // When
                
        // Then
        XCTAssertTrue(app.staticTexts["Tutorial Hints Text"].waitForExistence(timeout: 20))
        
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: 100, dy: 100))
        
        while(app.staticTexts["Tutorial Hints Text"].exists) {
            XCTAssertTrue(app.staticTexts["Tutorial Hints Text"].exists)
            coordinate.tap()
        }
        
        XCTAssertFalse(app.staticTexts["Tutorial Hints Text"].exists)
    }
    
    func test_InteractiveTutorialView_moreButton_shouldPopupTutorialOverlay() throws {
        // Given
        
        
        // When
        let moreButton = app.buttons["More Button"]
        moreButton.tap()
        
        let interactiveTutorialButton = app.buttons["Interactive Tutorial Button"]
        _ = interactiveTutorialButton.waitForExistence(timeout: 5)
        
        interactiveTutorialButton.tap()
        
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: 100, dy: 100))
                
        // Then
        XCTAssertTrue(app.staticTexts["Tutorial Hints Text"].waitForExistence(timeout: 5))
        
        while(app.staticTexts["Tutorial Hints Text"].exists) {
            XCTAssertTrue(app.staticTexts["Tutorial Hints Text"].exists)
            coordinate.tap()
        }
        
        XCTAssertFalse(app.staticTexts["Tutorial Hints Text"].exists)
    }
    
}
