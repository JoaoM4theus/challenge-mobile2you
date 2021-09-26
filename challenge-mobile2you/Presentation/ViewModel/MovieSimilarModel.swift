//
//  MovieSimilarModel.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 23/09/21.
//

import UIKit

protocol MovieSimilarDelegate: AnyObject {
    func finishFetchMovieSimilar()
    func loading()
    func finishLoading()
}

class MovieSimilarModel {
    var movieSimilar: [MovieSimilar]?
    var genres: GenresViewModel = GenresViewModel()
    weak var delegate: MovieSimilarDelegate?
    
    func getMovieSimilar(_ id: Int) {
        DispatchQueue.main.async {
            self.delegate?.loading()
        }
        let publicKey = Keys.publicKey.rawValue
        let url = MoviesAPIURL.getMovie.rawValue
        let id = id
        
        let requestURL = "\(url)/\(id)/similar?api_key=\(publicKey)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { data, error in
            guard let data = data else { return }
            if error == nil{
                do {
                    
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(SimilarMovieResponse.self, from: data){
                        self.movieSimilar = response.results
                        self.delegate?.finishFetchMovieSimilar()
                            self.delegate?.finishLoading()
                        
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func configCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let movieDetail = movieSimilar?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell") as! SimilarMovieCell
        let url = URL(string: MoviesAPIURL.image.rawValue + (movieDetail.poster_path ?? ""))
        cell.imagePoster.downloaded(from: url!)
        cell.nameMovieLabel.text = movieDetail.title
        
        let date = Resources.dateFormatter.date(from: movieDetail.release_date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        cell.dateMovieLabel.text = formatter.string(from: date ?? Date())
        
        if movieDetail.genre_ids.count > 1 {
            cell.genreMovieLabel.text = genres.getGenreName(id: movieDetail.genre_ids[0], second: movieDetail.genre_ids[1])
        } else {
            cell.genreMovieLabel.text = genres.getGenreName(id: movieDetail.genre_ids[0])
        }
        
        return cell
    }
}
