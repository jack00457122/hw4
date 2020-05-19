//
//  Death.swift
//  hw4
//
//  Created by User06 on 2020/5/18.
//  Copyright © 2020 bc. All rights reserved.
//

import Foundation

struct Death: Identifiable, Codable {
    var id = UUID()
    var EngName: String
    var appearance: String
    var selectedType: String
    var isAlive: Int 
}
