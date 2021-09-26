//
//  MovieRatedViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import UIKit

protocol MovieRatedDelegate: AnyObject {
    func fetchMovieRated()
    func failFetchRated()
}

class MovieRatedViewModel {
    var movie: [RatedMovie] = []
    weak var delegate: MovieRatedDelegate?
    
    func getMovieTopRated() {
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        
        let requestURL = "\(url)/top_rated?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(RatedMovieResponse.self, from: data){
                        self.movie = response.results
                        self.delegate?.fetchMovieRated()
                    } else {
                        self.delegate?.failFetchRated()
                    }
                }
            } else {
                self.delegate?.failFetchRated()
            }
        }
    }
    
    func configCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let movieRated = movie[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatedCollectionViewCell", for: indexPath) as? MovieRatedCollectionViewCell else { return  UICollectionViewCell() }

        cell.imagePoster.downloaded(from: URL(string: MoviesAPIURL.image.rawValue + (movieRated.poster_path ?? ""))!)
        return cell
    }
}
