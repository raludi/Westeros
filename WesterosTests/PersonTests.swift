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
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {//Aqui inicializamos las variables para no estar repitiendo todo el rato
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo")
        lannisterSigil = Sigil(image: UIImage(), description: "León")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterExistence() {
        XCTAssertNotNil(robb)
        XCTAssertNotNil(arya)
    }
    
    func testPerson_FullName_ShouldReturnTheNameAndTheHouseName() {
        XCTAssertEqual(robb.fullName, "Robb Stark")
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(tyrion, tyrion)
        
        //Igualdad
        let enano = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        XCTAssertEqual(enano, tyrion)
        
        //Desigualdad
        XCTAssertNotEqual(tyrion, arya)
    }
}


