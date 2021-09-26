//
//  SearchMovie.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

struct SearchMovieResponse: Codable {
    let results: [SearchMovie]
}

struct SearchMovie: Codable {
    let original_title: String
    let id: Int
}
