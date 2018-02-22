//
//  Episode.swift
//  Westeros
//
//  Created by Rafael Lujan on 21/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

// MARK: - Episode
final class Episode {
    let title: String
    let issueDate: Date
    let summary: String
    weak var season: Season?
    
    init(title: String, issueDate: Date, summary: String, season: Season) {
        self.title = title
        self.issueDate = issueDate
        self.summary = summary
        self.season = season
    }
    
    convenience init(title: String, issueDate: Date, season: Season) {
        self.init(title: title, issueDate: issueDate, summary: "Esto es el resumen", season: season)
    }
}


// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "Episode: \(title)"
    }
}
// MARK: - Proxy
extension Episode {
    var proxyEquality: String {
        return "\(title) \(issueDate)"
    }
    var proxyComparison: Date {
        return issueDate
    }
}
// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyEquality.hashValue//Patrón proxy
    }
}
// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyEquality == rhs.proxyEquality
    }
}
// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyComparison < rhs.proxyComparison
    }
}


