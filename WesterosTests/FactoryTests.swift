//
//  FactoryTests.swift
//  WesterosTests
//
//  Created by Rafael Lujan on 13/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import XCTest
@testable import Westeros

class FactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLoclRepositoryHousesCreation() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
        XCTAssertNotEqual(houses.count, 0)
    }
}
