//
//  PopularMovie.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

struct PopularMovieResponse: Codable {
    let results: [PopularMovie]
}

struct PopularMovie: Codable {
    let poster_path: String?
    let id: Int
}
