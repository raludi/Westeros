//
//  Repository.swift
//  Westeros
//
//  Created by Rafael Lujan on 13/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import Foundation

typealias Filter = (House) -> Bool

final class Repository {
    static let local = LocalFactory()
    //static let remote
}

//Acordarse de poner protocolos buenas practicas
protocol HouseFactory {
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

protocol SeasonFactory {
    var seasons: [Season] { get }
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    var houses: [House] {
        //Creations
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Wolf")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "Lion")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Drake")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fire and blood",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "Young Wolf", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "The dwarf", house: lannisterHouse)
        let cercei = Person(name: "Cercei", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Mother of dragons", house: targaryenHouse)
        
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, cercei)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter({ $0.name.uppercased() == name.uppercased() }).first
        return house
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    var seasons: [Season] {
        let season1 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "17/04/2011"))
        let season2 = Season(name: "Season 2", releaseDate: givingDateFormatted(date: "01/04/2012"))
        let season3 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "31/03/2013"))
        let season4 = Season(name: "Season 2", releaseDate: givingDateFormatted(date: "06/04/2014"))
        let season5 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "12/04/2015"))
        let season6 = Season(name: "Season 2", releaseDate: givingDateFormatted(date: "24/04/2016"))
        let season7 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "16/07/2017"))
        //Season1
        let episode1 = Episode(title: "Winter Is Coming", issueDate: givingDateFormatted(date: "17/04/2011"), season: season1)
        let episode2 = Episode(title: "The Kingsroad", issueDate: givingDateFormatted(date: "24/04/2011"), season: season1)
        //Season2
        let episode3 = Episode(title: "The North Remembers", issueDate: givingDateFormatted(date: "01/04/2012"), season: season2)
        let episode4 = Episode(title: "The Night Lands", issueDate: givingDateFormatted(date: "08/04/2012"), season: season2)
        //Season3
        let episode5 = Episode(title: "Valar Dohaeris", issueDate: givingDateFormatted(date: "31/03/2013"), season: season3)
        let episode6 = Episode(title: "Dark Wings, Dark Words", issueDate: givingDateFormatted(date: "07/04/2013"), season: season3)
        //Season4
        let episode7 = Episode(title: "Two Swords", issueDate: givingDateFormatted(date: "06/04/2014"), season: season4)
        let episode8 = Episode(title: "The Lion and the Rose", issueDate: givingDateFormatted(date: "13/04/2014"), season: season4)
        //Season5
        let episode9 = Episode(title: "The Wars to Come", issueDate: givingDateFormatted(date: "12/04/2015"), season: season5)
        let episode10 = Episode(title: "The House of Black and White", issueDate: givingDateFormatted(date: "19/04/2015"), season: season5)
        //Season6
        let episode11 = Episode(title: "The Red Woman", issueDate: givingDateFormatted(date: "24/04/2016"), season: season6)
        let episode12 = Episode(title: "Home", issueDate: givingDateFormatted(date: "01/05/2016"), season: season6)
        //Season7
        let episode13 = Episode(title: "Dragonstone", issueDate: givingDateFormatted(date: "16/07/2017"), season: season7)
        let episode14 = Episode(title: "Stormborn", issueDate: givingDateFormatted(date: "23/07/2017"), season: season7)
        
        season1.add(newEpisodes: episode1, episode2)
        season2.add(newEpisodes: episode3, episode4)
        season3.add(newEpisodes: episode5, episode6)
        season4.add(newEpisodes: episode7, episode8)
        season5.add(newEpisodes: episode9, episode10)
        season6.add(newEpisodes: episode11, episode12)
        season7.add(newEpisodes: episode13, episode14)
       
        return [season1, season2, season3, season4, season5, season6, season7]
    }
    
    
}




