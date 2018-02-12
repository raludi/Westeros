//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Rafael Lujan on 11/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!
    
    override func setUp() {//Aqui inicializamos las variables para no estar repitiendo todo el rato
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func characterExistence() {
        let john = Person(name: "John", alias: "Snow", house: starkHouse)
        XCTAssertNotNil(john)
        let arya = Person(name: "Arya", house: starkHouse)
        XCTAssertNotNil(arya)
    }
    
}
