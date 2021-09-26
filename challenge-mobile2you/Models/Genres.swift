//
//  Genres.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 25/09/21.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}
