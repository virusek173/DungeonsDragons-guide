//
//  Spell.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 25/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import Foundation

struct Spell: Codable {
    var name: String
    var desc: [String]
    var range: String
    var duration: String
    var level: Int
}
