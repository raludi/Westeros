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
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo")
        lannisterSigil = Sigil(image: UIImage(), description: "León")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming",
                               url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar",
                                   url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testAddPersons() {
        XCTAssertEqual(starkHouse.countMembers, 0)        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.countMembers, 1)
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.countMembers, 1)
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.countMembers, 2)
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.countMembers, 2)
        
        let jaime = Person(name: "Tyrion", alias: "The dwarf", house: lannisterHouse)
        let cercei = Person(name: "Cercei", house: lannisterHouse)
        
        lannisterHouse.add(persons: cercei,jaime)
        XCTAssertEqual(lannisterHouse.countMembers, 2)
    }
    
    func testHouseEquality() {
        //Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        //Igualdad
        let winter = House(name: "Stark", sigil: starkSigil, words: "Winter is coming",
                           url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        XCTAssertEqual(winter, starkHouse)
        //Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseReturnsSortedArrayOfMembers() {
        
    }
}
