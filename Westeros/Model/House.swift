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
    let wikiURL: URL
    private var _members: Members

    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members() //Al poner parentesis lo ponemos vacio
    }
}

extension House {
    var countMembers: Int {
        return _members.count
    }
    
    var sortedMember: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {//Los "..." son valores infinitos separados por ","
        /*for person in persons {
            add(person: person)
        }*/
        persons.forEach( { add(person: $0) })
    }
}

//MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(countMembers) \(words)" //Por convención devolver un Int y añadir .hashValue al final del valor
    }
    var proxyForComparison: String {
        return name.uppercased()
    }
}
//MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
//MARK: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}
//MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    //No hace falta implementar el resto funciones porque con el "==" y "<" swift lo implementa automaticamente todo
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


