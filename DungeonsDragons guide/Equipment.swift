//
//  Equipment.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 26/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import Foundation

struct Equipment: Codable {
    var name: String
    var equipment_category: String
    var desc: [String]?
    var weight: Int?
}
