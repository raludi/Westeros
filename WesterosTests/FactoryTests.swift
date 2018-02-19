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
    
    var localHouses: [House]!
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLoclRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertNotEqual(localHouses.count, 0)
    }
    
    func testLocalRepository_ShouldReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepository_ShouldReturnsHouseByCaseInsensitive() {
        let stark = Repository.local.house(named: "StARK")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "KeepCoding")
        XCTAssertNil(keepcoding)
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.countMembers == 1 })
        XCTAssertEqual(filtered.count, 1)
        let otherFilter = Repository.local.houses(filteredBy: { $0.words.contains("Winter") })
        XCTAssertEqual(otherFilter.count, 1)
    }
}
