//
//  SimilarMovie.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

struct SimilarMovieResponse: Codable {
    let results: [MovieSimilar]
}

struct MovieSimilar: Codable {
    let poster_path: String?
    let title: String
    let release_date: String
    let genre_ids: [Int]
}
