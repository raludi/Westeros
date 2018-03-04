//
//  Repository.swift
//  Westeros
//
//  Created by Rafael Lujan on 13/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import Foundation

typealias Filter = (House) -> Bool
typealias FilterSeason = (Season) -> Bool

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
        let tyrrelSigil = Sigil(image: #imageLiteral(resourceName: "tyrrel.jpg"), description: "Gold Flower")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fire and blood",
                                url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        let tyrrelHouse = House(name: "Tyrrel", sigil: tyrrelSigil, words: "Growing Strong", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Tyrell")!)
        
        _ = Person(name: "Robb", alias: "Young Wolf", house: starkHouse)
        _ = Person(name: "Arya", house: starkHouse)
        _ = Person(name: "Tyrion", alias: "The dwarf", house: lannisterHouse)
        _ = Person(name: "Cercei", house: lannisterHouse)
        _ = Person(name: "Daenerys", alias: "Mother of dragons", house: targaryenHouse)
        _ = Person(name: "Margaery", house: tyrrelHouse)
        
        return [starkHouse, lannisterHouse, targaryenHouse, tyrrelHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter({ $0.name.uppercased() == name.uppercased() }).first
        return house
    }
    
    func house(named name: HousesName) -> House? {
        let house = houses.filter({ $0.name.uppercased() == name.rawValue.uppercased() }).first
        return house
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    var seasons: [Season] {
        let season1 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "17/04/2011"), image: #imageLiteral(resourceName: "season1.jpeg"))
        let season2 = Season(name: "Season 2", releaseDate: givingDateFormatted(date: "01/04/2012"), image: #imageLiteral(resourceName: "season2.jpg"))
        let season3 = Season(name: "Season 3", releaseDate: givingDateFormatted(date: "31/03/2013"), image: #imageLiteral(resourceName: "season3.jpg"))
        let season4 = Season(name: "Season 4", releaseDate: givingDateFormatted(date: "06/04/2014"), image: #imageLiteral(resourceName: "season4.jpg"))
        let season5 = Season(name: "Season 5", releaseDate: givingDateFormatted(date: "12/04/2015"), image: #imageLiteral(resourceName: "season-5.jpg"))
        let season6 = Season(name: "Season 6", releaseDate: givingDateFormatted(date: "24/04/2016"), image: #imageLiteral(resourceName: "season-6.jpg"))
        let season7 = Season(name: "Season 7", releaseDate: givingDateFormatted(date: "16/07/2017"), image: #imageLiteral(resourceName: "season7.jpg"))
        //Season1
        _ = Episode(title: "Winter Is Coming", issueDate: givingDateFormatted(date: "17/04/2011"), summary: "This is the summary of episode 1", season: season1)
        _ = Episode(title: "The Kingsroad", issueDate: givingDateFormatted(date: "24/04/2011"), summary: "This is the summary of episode 2", season: season1)
        //Season2
        _ = Episode(title: "The North Remembers", issueDate: givingDateFormatted(date: "01/04/2012"), summary: "This is the summary of episode 1", season: season2)
        _ = Episode(title: "The Night Lands", issueDate: givingDateFormatted(date: "08/04/2012"), summary: "This is the summary of episode 2", season: season2)
        //Season3
        _ = Episode(title: "Valar Dohaeris", issueDate: givingDateFormatted(date: "31/03/2013"), summary: "This is the summary of episode 1", season: season3)
        _ = Episode(title: "Dark Wings, Dark Words", issueDate: givingDateFormatted(date: "07/04/2013"), summary: "This is the summary of episode 2", season: season3)
        //Season4
        _ = Episode(title: "Two Swords", issueDate: givingDateFormatted(date: "06/04/2014"), summary: "This is the summary of episode 1", season: season4)
        _ = Episode(title: "The Lion and the Rose", issueDate: givingDateFormatted(date: "13/04/2014"), summary: "This is the summary of episode 2", season: season4)
        //Season5
        _ = Episode(title: "The Wars to Come", issueDate: givingDateFormatted(date: "12/04/2015"), summary: "This is the summary of episode 1", season: season5)
        _ = Episode(title: "The House of Black and White", issueDate: givingDateFormatted(date: "19/04/2015"), summary: "This is the summary of episode 2", season: season5)
        //Season6
        _ = Episode(title: "The Red Woman", issueDate: givingDateFormatted(date: "24/04/2016"), summary: "This is the summary of episode 1", season: season6)
        _ = Episode(title: "Home", issueDate: givingDateFormatted(date: "01/05/2016"), summary: "This is the summary of episode 2", season: season6)
        //Season7
        _ = Episode(title: "Dragonstone", issueDate: givingDateFormatted(date: "16/07/2017"), summary: "This is the summary of episode 1", season: season7)
        _ = Episode(title: "Stormborn", issueDate: givingDateFormatted(date: "23/07/2017"), summary: "This is the summary of episode 2", season: season7)

        /*let data = episodeModel.data(using: .utf8)!
         var seasons = [Season]()
         do {
             let jsonList = try JSONDecoder().decode([Episode].self, from: data)
             jsonList.forEach({ episode in
                 guard let season = episode.season else { return }
                 seasons.append(season)
                 print(seasons)
             })
             print(jsonList)
         } catch {
            print("Error -> \(error)")
         }*/
 
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func seasons(filteredBy: FilterSeason) -> [Season] {
        return seasons.filter(filteredBy)
    }
    
    func season(named name: String) -> Season? {
        let house = seasons.filter({ $0.name.uppercased() == name.uppercased() }).first
        return house
    }
}




