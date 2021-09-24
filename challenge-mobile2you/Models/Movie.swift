//
//  Movie.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 22/09/21.
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

struct MovieDetail: Codable {
    let id: Int
    let imdb_id: String?
    let adult: Bool
    let backdrop_path: String?
    let budget: Int
    let genres: [Genres]
    let homepage: String?
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let production_companies: [Companies]
    let production_countries: [Countries]
    let release_date: String
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

struct Genres: Codable {
    let id: Int
    let name: String
}

struct Companies: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
}

struct Countries: Codable {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguage: Codable {
    let english_name: String
    let iso_639_1: String
    let name: String
}

