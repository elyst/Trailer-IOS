//
//  MovieObject.swift
//  John500761399
//
//  Created by John Verdonck on 01/05/2019.
//  Copyright © 2019 John Verdonck. All rights reserved.
//

import Foundation

struct MovieObject: Codable {
    let id: Int
    let title: String
    let url: String
    let posterImage: String
    let stillImage: String
    let description: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case url = "url"
        case posterImage = "posterImage"
        case stillImage = "stillImage"
        case description = "description"
    }
}
