//
//  NetworkingTest.swift
//  MockAppTests
//
//  Created by Egor Gorskikh on 08.09.2021.
//

import XCTest
import Mockingbird
@testable import MockApp

class NetworkingTests: XCTestCase {
    var mockNetwork: Networkable!
    var symbol = "USD"
    var ffaa = ""
    
    override func setUp() {
        super.setUp()
        mockNetwork = mock(Networkable.self)
    }
    
    override func tearDown() {
        mockNetwork = nil
        super.tearDown()
    }
    
    func test_succes() {

        mockNetwork.getMethod { data in
            guard let data = data else { return }
            self.ffaa = data.USD.symbol.description
        }
        
        XCTAssertEqual(symbol, ffaa)
    }
    
    func test_error() {
        symbol = "USD34343"
        
        mockNetwork.getMethod { data in
            guard let data = data else { return }
            self.ffaa = data.USD.symbol.description
        }
        
         XCTAssertEqual(symbol, ffaa)
    }

}



