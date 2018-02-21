//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Rafael Lujan on 21/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    
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
    
    func testEpisodeExistance() {
        XCTAssertNotNil(chapter1)
        XCTAssertNotNil(chapter2)
        XCTAssertNotNil(chapter3)
    }
    
    func testEpisodesEquality() {
        XCTAssertEqual(chapter1, chapter1)
    }
    
    func testEpisodesComparison() {
        XCTAssertLessThan(chapter1, chapter2)
    }
    
    func testEpisodesDescription() {
        XCTAssertEqual(chapter1.description, "Episode: \(chapter1.title)")
    }
    
}
