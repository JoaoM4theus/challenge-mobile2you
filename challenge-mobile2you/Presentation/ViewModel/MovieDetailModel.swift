//
//  MovieDetailModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 22/09/21.
//

import Foundation

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
