//
//  InteractiveTutorialViewModelTests.swift
//  visualizerTests
//
//  Created by Andrew Li on 10/2/2022.
//

import XCTest
@testable import visualizer

class InteractiveTutorialViewModelTests: XCTestCase {
    var pitchInteractiveTutorialViewModel: InteractiveTutorialViewModel?
    var timbreInteractiveTutorialViewModel: InteractiveTutorialViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pitchInteractiveTutorialViewModel = InteractiveTutorialViewModel(page: InteractiveTutorial.Page.pitch)
        timbreInteractiveTutorialViewModel = InteractiveTutorialViewModel(page: InteractiveTutorial.Page.timbre)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pitchInteractiveTutorialViewModel = nil
        timbreInteractiveTutorialViewModel = nil
    }

    func test_InteractiveTutorialViewModel_currentPage_shouldBeZero() {
        // Given
        
        // When
        let vm1 = InteractiveTutorialViewModel(page: InteractiveTutorial.Page.pitch)
        let vm2 = InteractiveTutorialViewModel(page: InteractiveTutorial.Page.timbre)
        
        // Then
        XCTAssertEqual(vm1.currentPage, 0)
        XCTAssertEqual(vm2.currentPage, 0)
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldBeIncreased() {
        // Given
        guard let vm1 = pitchInteractiveTutorialViewModel else { XCTFail(); return }
        guard let vm2 = timbreInteractiveTutorialViewModel else { XCTFail(); return }
        
        for vm in [vm1, vm2] {
            let prev = vm.currentPage
            
            // When
            let status = vm.handleNextInstruction()
            
            // Then
            XCTAssertNotEqual(vm.currentPage, 0)
            XCTAssertGreaterThan(vm.currentPage, 0)
            XCTAssertGreaterThan(vm.currentPage, prev)
            XCTAssertFalse(status)   // Return false to not dismissing tutorial
        }
        
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldAllBeIncreased() {
        // Given
        guard let vm1 = pitchInteractiveTutorialViewModel else { XCTFail(); return }
        guard let vm2 = timbreInteractiveTutorialViewModel else { XCTFail(); return }
        
        for vm in [vm1, vm2] {
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
    }
    
    func test_InteractiveTutorialViewModel_currentPage_shouldNotIncreaseWhenExceedTutorialsLength() {
        // Given
        guard let vm1 = pitchInteractiveTutorialViewModel else { XCTFail(); return }
        guard let vm2 = timbreInteractiveTutorialViewModel else { XCTFail(); return }
        
        for vm in [vm1, vm2] {
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
}
