//
//  Repository.swift
//  Westeros
//
//  Created by Rafael Lujan on 13/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()
    //static let remote
}
//Acordarse de poner protocolos buenas practicas
protocol HouseFactory {
    var houses: [House] { get }
    func house(named: String) -> House?
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        //Creations
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Wolf")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Lion")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Drake")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar")
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fire and blood")
        
        let robb = Person(name: "Robb", alias: "Young Wolf", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "The dwarf", house: lannisterHouse)
        let cercei = Person(name: "Cercei", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Mother of dragons", house: targaryenHouse)
        
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cercei)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter({ $0.name.uppercased() == name.uppercased() }).first
        return house
    }
}


