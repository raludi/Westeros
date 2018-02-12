//
//  Character.swift
//  Westeros
//
//  Created by Rafael Lujan on 11/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
        if let _alias = _alias {
            //Si existe y no es null
            return _alias
        } else {
            return ""
        }
        //ALTERNATIVA: _alias ?? "" -> si existes devuelves ""
    }
    
    init(name: String, alias: String, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
    
    init(name: String, house: House) {
        self.name = name
        self.house = house
        _alias = nil
    }
}
