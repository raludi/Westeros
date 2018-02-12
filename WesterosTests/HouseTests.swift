//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Rafael Lujan on 11/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import XCTest
@testable import Westeros //IMPORTANTE AÑADIR LA REFERENCIA AL PROYECTO DE LAS PRUEBAS

class HouseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHouseExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo")
        let stark = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo")
        XCTAssertNotNil(starkSigil)
        let lannisterSigil = Sigil(image: UIImage(), description: "León")
        XCTAssertNotNil(lannisterSigil)
    }
}
