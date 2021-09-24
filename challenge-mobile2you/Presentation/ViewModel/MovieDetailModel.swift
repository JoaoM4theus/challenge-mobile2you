//
//  MovieDetailModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 22/09/21.
//

import Foundation

enum Keys: String {
    case publicKey = "eca46b71e0db1ad54a0261f6783df094"
}

enum MoviesAPIURL: String {
//    case getSimilar = "https://api.themoviedb.org/3/movie"
    case getMovie = "https://api.themoviedb.org/3/movie"
    case image = "https://image.tmdb.org/t/p/w500"
}

protocol MovieDetailDelegate: AnyObject {
    func finishFetchMovieDetail()
    func loading()
    func finishLoading()
}

class MovieDetailModel {
    var movie: MovieDetail?
    weak var delegate: MovieDetailDelegate?
    
    func getMovieDetail() {
        DispatchQueue.main.async {
            self.delegate?.loading()
        }
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        let id = 250 //DEFAULT
        
        let requestURL = "\(url)/\(id)?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(MovieDetail.self, from: data){
                        self.movie = response
                        DispatchQueue.main.async {
                            self.delegate?.finishLoading()
                        }
                        self.delegate?.finishFetchMovieDetail()
                        
                    } else {
                        
                    }
                }
            }
        }
    }
}
