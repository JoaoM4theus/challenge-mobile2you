//
//  MovieDetailModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 22/09/21.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    func finishFetchMovieDetail()
    func failFetchMovieDetail()
}

class MovieDetailModel {
    var favorite = false
    var movie: MovieDetail?
    weak var delegate: MovieDetailDelegate?
    
    func getMovieDetail(_ id: Int) {
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        let id = id //DEFAULT
        
        let requestURL = "\(url)/\(id)?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(MovieDetail.self, from: data){
                        self.movie = response
                        self.delegate?.finishFetchMovieDetail()
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func configDetailMovie(imagePoster: UIImageView, nameMovieLabel: UILabel, likesMovieLabel: UILabel, popularityMovieLabel: UILabel, shadow: UIView){
        guard let movieDetail = movie else { return }
        let url = URL(string: MoviesAPIURL.image.rawValue + (movieDetail.poster_path ?? ""))
        let data = try? Data(contentsOf: url!)
        imagePoster.image = UIImage(data: data!)
        nameMovieLabel.text = movieDetail.title
        likesMovieLabel.text = "\(movieDetail.vote_count) likes"
        popularityMovieLabel.text = "\(movieDetail.vote_average) popularity"
        
        shadow.clipsToBounds = false
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.5
        shadow.layer.shadowPath = UIBezierPath(roundedRect: shadow.bounds, cornerRadius: 10).cgPath
    }
    
    func favoriteButton(sender: UIButton) {
        let imageString = favorite ? "suit.heart" : "suit.heart.fill"
        favorite = !favorite
        sender.setImage(UIImage(systemName: imageString), for: .normal)
    }
}
