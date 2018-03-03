//
//  Season.swift
//  Westeros
//
//  Created by Rafael Lujan on 21/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    let image: UIImage
  
    init(name: String, releaseDate: Date, image: UIImage) {
        self.name = name
        self.releaseDate = releaseDate
        self.image = image
        self._episodes = Episodes()
    }
    
    convenience init(name: String, releaseDate: Date) {
        self.init(name: name, releaseDate: releaseDate,  image: UIImage())
        self._episodes = Episodes()
    }
}

extension Season {
    var countEpisodes: Int {
        return _episodes.count
    }
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    func add(newEpisode: Episode) {
       
        guard self.releaseDate <= newEpisode.issueDate else {
             return
        }
        _episodes.insert(newEpisode)
    }
    func add(newEpisodes: Episode...) {
        newEpisodes.forEach( { add(newEpisode: $0) })
    }
}

// MARK: - Proxy
extension Season {
    var proxyEquality: String {
        return "\(name)"
    }
    var proxyComparison: Date {
        return releaseDate
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "Season: \(name)"
    }
}
// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyEquality.hashValue
    }
}
// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyEquality == rhs.proxyEquality
    }
}
// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyComparison < rhs.proxyComparison
    }
}

extension Season: Decodable {
    
    enum mySeasonKeys: String, CodingKey {
        case name = "name"
        case releaseDate = "releaseDate"
        case image = "image"
    }
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: mySeasonKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        let image = try container.decode(String.self, forKey: .image)
        
        self.init(name: name, releaseDate: givingDateFormatted(date: releaseDate), image: UIImage(named: image)!)
    }
}
    

