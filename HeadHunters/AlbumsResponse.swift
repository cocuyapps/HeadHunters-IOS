//
//  AlbumsResponse.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation

struct AlbumsResponse: Codable {
    var status: String
    var code: String?
    var message: String?
    var totalResults: Int?
    var albums: [Album]?
}
