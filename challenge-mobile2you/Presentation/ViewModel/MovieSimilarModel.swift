//
//  MovieSimilarModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 23/09/21.
//

import Foundation

protocol MovieSimilarDelegate: AnyObject {
    func finishFetchMovieSimilar()
    func loading()
    func finishLoading()
}

class MovieSimilarModel {
    var movieSimilar: [MovieSimilar]?
    weak var delegate: MovieSimilarDelegate?
    
    func getMovieSimilar() {

        DispatchQueue.main.async {
            self.delegate?.loading()
        }
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        let id = 250 //DEFAULT
        
        let requestURL = "\(url)/\(id)/similar?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(SimilarMovieResponse.self, from: data){
                        self.movieSimilar = response.results
                        DispatchQueue.main.async {
                            self.delegate?.finishLoading()
                        }
                        self.delegate?.finishFetchMovieSimilar()
                    } else {
                        
                    }
                }
            }
        }
    }
}
