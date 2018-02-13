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
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        //Creations
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        
        return [starkHouse, lannisterHouse]
    }
}


