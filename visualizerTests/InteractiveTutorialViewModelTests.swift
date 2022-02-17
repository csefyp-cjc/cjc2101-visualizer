//
//  InteractiveTutorialViewModelTests.swift
//  visualizerTests
//
//  Created by Andrew Li on 10/2/2022.
//

import XCTest
@testable import visualizer

class InteractiveTutorialViewModelTests: XCTestCase {
    var interactiveTutorialViewModel: InteractiveTutorialViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactiveTutorialViewModel = InteractiveTutorialViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactiveTutorialViewModel = nil
    }

    func test_InteractiveTutorialViewModel_currentPage_shouldBeZero() {
        // Given
        
        // When
        let vm = InteractiveTutorialViewModel()
        
        // Then
        XCTAssertEqual(vm.currentPage, 0)
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldBeIncreased() {
        // Given
        let vm = InteractiveTutorialViewModel()
        let prev = vm.currentPage
        
        // When
        let status = vm.handleNextInstruction()
        
        // Then
        XCTAssertNotEqual(vm.currentPage, 0)
        XCTAssertGreaterThan(vm.currentPage, 0)
        XCTAssertGreaterThan(vm.currentPage, prev)
        XCTAssertFalse(status)   // Return false to not dismissing tutorial
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldAllBeIncreased() {
        // Given
        let vm = InteractiveTutorialViewModel()
        let prev = vm.currentPage
        
        // When
        var status: Bool = false
        let instructionCounts = Int.random(in: 1...vm.tutorials.count-1)
        for _ in 0..<instructionCounts {
            status = vm.handleNextInstruction()
        }
        
        // Then
        XCTAssertNotEqual(vm.currentPage, 0)
        XCTAssertGreaterThan(vm.currentPage, prev)
        XCTAssertLessThan(vm.currentPage, vm.tutorials.count)
        XCTAssertFalse(status)   // Return true to dismiss tutorial
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldNotIncreaseWhenExceedTutorialsLength() {
        // Given
        guard let vm = interactiveTutorialViewModel else { XCTFail(); return }
        let prev = vm.currentPage
        
        // When
        var status: Bool = false
        for _ in 0..<vm.tutorials.count {
            status = vm.handleNextInstruction()
        }
        
        // Then
        XCTAssertNotEqual(vm.currentPage, 0)
        XCTAssertGreaterThan(vm.currentPage, prev)
        XCTAssertLessThan(vm.currentPage, vm.tutorials.count)
        XCTAssertTrue(status)   // Return true to dismiss tutorial
    }
}
