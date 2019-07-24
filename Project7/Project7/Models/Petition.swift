//
//  Petitions.swift
//  Project7
//
//  Created by Alex Ladines on 7/24/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import Foundation

// Petition contains types that conform to Codable, so we can do : Codable
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

