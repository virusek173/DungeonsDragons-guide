//
//  Monster.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 15/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import Foundation

struct Monster: Codable {
    var name: String
    var alignment: String
    var languages: String
    var legendary_actions: [Action]?
    var actions: [Action]?
}
