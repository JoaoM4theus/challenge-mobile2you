//
//  ValidationSearchTests.swift
//  challenge-mobile2youTests
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import XCTest
@testable import challenge_mobile2you

class ValidationSearchTests: XCTestCase {
    var validation: ValidationSearch!
     
    override func setUp() {
        super.setUp()
        validation = ValidationSearch()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    func test_is_valid_search() throws {
        XCTAssertNoThrow(try validation.validateSearchText("Avengers"))
    }
}
