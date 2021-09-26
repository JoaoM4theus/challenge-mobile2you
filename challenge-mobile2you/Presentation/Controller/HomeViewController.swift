//
//  HomeViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 25/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - IBOUTLET
    @IBOutlet weak var collectionMoviePopularView: UICollectionView!
    @IBOutlet weak var collectionMovieRatedView: UICollectionView!
    
    var popularModel: MoviePopularViewModel = MoviePopularViewModel()
    var topRatedModel: MovieRatedViewModel = MovieRatedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMoviePopularView.delegate = self
        collectionMoviePopularView.dataSource = self
        collectionMovieRatedView.delegate = self
        collectionMovieRatedView.dataSource = self
        popularModel.getMoviePopular()
        topRatedModel.getMovieTopRated()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionMoviePopularView {
            return popularModel.movie.count
        }
        
        return topRatedModel.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionMoviePopularView {
            let moviePopular = popularModel.movie[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePopularCollectionViewCell", for: indexPath) as? MoviePopularCollectionViewCell else { return  UICollectionViewCell() }
            
            let url = URL(string: MoviesAPIURL.image.rawValue + (moviePopular.poster_path ?? ""))
            let data = try? Data(contentsOf: url!)
            cell.imagePoster.image = UIImage(data: data!)
            print(moviePopular.id)
            return cell
        } else {
            let movieRated = topRatedModel.movie[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatedCollectionViewCell", for: indexPath) as? MovieRatedCollectionViewCell else { return UICollectionViewCell()}
            
            let url = URL(string: MoviesAPIURL.image.rawValue + (movieRated.poster_path ?? ""))
            let data = try? Data(contentsOf: url!)
            cell.imagePoster.image = UIImage(data: data!)
            print(movieRated.id)
            return cell
        }
    }
}
