//
//  SearchMovieViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

protocol SearchMovieDelegate: AnyObject {
    func finishFetchMovie()
    func failFetchMovie(message: String)
}

class SearchMovieViewModel {
    var movie: [SearchMovie] = []
    weak var delegate: SearchMovieDelegate?
    
    func getMovieSearch(nameSearch: String) {
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getSearchMovie.rawValue
        
        let requestURL = "\(url)/?api_key=\(publicKey)&query=\(nameSearch)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(SearchMovieResponse.self, from: data){
                        self.movie = response.results
                        
                        if !self.movie.isEmpty {
                            self.delegate?.finishFetchMovie()
                        } else {
                            self.delegate?.failFetchMovie(message: "Movie not found")
                        }
                    } else {
                        self.delegate?.failFetchMovie(message: "An unexpected error happened")
                    }
                }
            } else {
                self.delegate?.failFetchMovie(message: "An unexpected error happened")
            }
        }
    }
}
