//
//  SearchMovieViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

class SearchMovieViewModel {
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
                        print(response)
                    } else {
                        print("erro")
                    }
                }
            }
        }
    }
}
