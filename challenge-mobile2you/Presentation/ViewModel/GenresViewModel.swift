//
//  GenresViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 25/09/21.
//

import Foundation

class GenresViewModel {
    var genres: [Genres] = []
    
    func getGenres() {
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        let requestURL = "\(url)/list?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(GenresResponse.self, from: data){
                        print(response)
                        self.genres = response.genres
                    } else {
                        print("erro")
                    }
                }
            }
        }
    }
}
