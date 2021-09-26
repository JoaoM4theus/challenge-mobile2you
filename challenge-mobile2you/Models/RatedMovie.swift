//
//  RatedMovie.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

struct RatedMovieResponse: Codable {
    let results: [RatedMovie]
}

struct RatedMovie: Codable {
    let poster_path: String?
    let id: Int
}
