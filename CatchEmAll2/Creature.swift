//
//  Creature.swift
//  CatchEmAll2
//
//  Created by Christian Manzaraz on 12/02/2025.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String // url for detail of pokemon
    
    enum CodingKeys: CodingKey { // ignore the ID property when decoding
        case name
        case url
    }
}
