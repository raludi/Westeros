//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Rafael Lujan on 21/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    var season3: Season!
    var chapter1: Episode!
    var chapter2: Episode!
    var chapter3: Episode!
    
    override func setUp() {
        super.setUp()
        season1 = Season(name: "Season 1", releaseDate: givingDateFormatted(date: "17/04/2011"))
        season2 = Season(name: "Season 2", releaseDate: givingDateFormatted(date: "01/04/2012"))
        
        chapter1 = Episode(title: "Winter Is Coming", issueDate: givingDateFormatted(date: "17/04/2011"), summary: "Summary 1", season: season1)
        chapter2 = Episode(title: "Title2", issueDate: givingDateFormatted(date: "17/05/2011"), summary: "Summary 2", season: season1)
        chapter3 = Episode(title: "Title3", issueDate: givingDateFormatted(date: "17/04/2014"), summary: "Summary 2", season: season2)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistance() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testEpisodesEquality() {
        XCTAssertEqual(season1, season1)
    }
    
    func testEpisodesComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testEpisodesDescription() {
        XCTAssertEqual(season1.description, "Season: \(season1.name)")
    }
    
    func testAddNewEpisodeToSeason() {
        /*XCTAssertEqual(season2.countEpisodes, 0)
        season2.add(newEpisode: chapter1)
        XCTAssertEqual(season2.countEpisodes, 0)
        season2.add(newEpisode: chapter3)
        XCTAssertEqual(season2.countEpisodes, 1)*/
        XCTAssertEqual(season1.countEpisodes, 2)
    }
    
}
