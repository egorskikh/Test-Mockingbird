//
//  MockAppTests.swift
//  MockAppTests
//
//  Created by Egor Gorskikh on 07.09.2021.
//

import XCTest
import Mockingbird
@testable import MockApp

class MockAppTests: XCTestCase {
    
    var sut: Person!
    var mockBirdble: Birdble!
    
    override func setUp() {
        super.setUp()
        sut = Person()
        mockBirdble = mock(Birdble.self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_example() {
        // given
        // when
        // then
    }
    
    func test_init_mock() {
        XCTAssertNotNil(mockBirdble)
    }
    
    func test_can_fly() {
        // Given
        given(mockBirdble.canFly).willReturn(true)

        // When
        sut.release(mockBirdble)

        // Then
        verify(mockBirdble.fly()).wasCalled(1)
    }
    
    func test_cant_fly() {
        // Given
        given(mockBirdble.canFly).willReturn(false)

        // When
        sut.release(mockBirdble)

        // Then
        verify(mockBirdble.fly()).wasNeverCalled()
    }
    
    func test_canFly_was_called_before_fly() {
    
        // Non-greedy strategy can start from the second `canFly`
//        inOrder(with: .noInvocationsAfter) {
//          verify(mockBirdble.canFly).wasCalled()
//          verify(mockBirdble.fly()).wasCalled()
//        }
        
    }
    
}
