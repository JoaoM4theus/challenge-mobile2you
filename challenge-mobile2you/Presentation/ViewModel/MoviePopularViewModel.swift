//
//  MoviePopularViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

class MoviePopularViewModel {
    var movie: [PopularMovie] = []
    func getMovieDetail() {
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        
        let requestURL = "\(url)/popular?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(PopularMovieResponse.self, from: data){
                        self.movie = response.results
                    } else {
                        print("erro")
                    }
                }
            }
        }
    }
}
