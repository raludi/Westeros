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
        self.season?.add(newEpisode: self)
    }
    
    convenience init(title: String, issueDate: Date, season: Season) {
        self.init(title: title, issueDate: issueDate, summary: "Without Summary", season: season)
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

extension Episode: Decodable {
    
    enum myEpisodeKeys: String, CodingKey {
        case title = "title"
        case issueDate = "issueDate"
        case summary = "summary"
        case season = "season"
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: myEpisodeKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let issueDate = try container.decode(String.self, forKey: .issueDate)
        let summary = try container.decode(String.self, forKey: .summary)
        let season = try container.decode(Season?.self, forKey: .season)
        
        self.init(title: title, issueDate: givingDateFormatted(date: issueDate), summary: summary, season: season!)
    }
}



