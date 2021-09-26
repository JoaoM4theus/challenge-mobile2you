//
//  MoviePopularViewModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import UIKit

protocol MoviePopularDelegate: AnyObject {
    func fetchMoviePopular()
    func failFetchPopular()
}

class MoviePopularViewModel {
    var movie: [PopularMovie] = []
    weak var delegate: MoviePopularDelegate?
    
    func getMoviePopular() {
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
                        self.delegate?.fetchMoviePopular()
                    } else {
                        self.delegate?.failFetchPopular()
                    }
                }
            } else {
                self.delegate?.failFetchPopular()
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func configCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let moviePopular = movie[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePopularCollectionViewCell", for: indexPath) as? MoviePopularCollectionViewCell else { return  UICollectionViewCell() }
        
        cell.imagePoster.downloaded(from: URL(string: MoviesAPIURL.image.rawValue + (moviePopular.poster_path ?? ""))!)
        return cell
    }
}
