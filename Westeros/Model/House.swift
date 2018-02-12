//
//  House.swift
//  Westeros
//
//  Created by Rafael Lujan on 11/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person>


// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    private var _members: Members

    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
        _members = Members() //Al poner parentesis lo ponemos vacio
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
}

//MARK: - Proxy
extension House {
    var proxyForEquality: String {
            return "\(name) \(count) \(words)" //Por convención devolver un Int y añadir .hashValue al final del valor
    }
}

extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Sigil
final class Sigil {
    let image: UIImage
    let description: String
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
        
    }
}


