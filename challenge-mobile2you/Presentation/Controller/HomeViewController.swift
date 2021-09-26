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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMoviePopularView.delegate = self
        collectionMoviePopularView.dataSource = self
        collectionMovieRatedView.delegate = self
        collectionMovieRatedView.dataSource = self
        popularModel.getMovieDetail()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionMoviePopularView {
            return popularModel.movie.count
        }
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionMoviePopularView {
            let movieDetail = popularModel.movie[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePopularCollectionViewCell", for: indexPath) as? MoviePopularCollectionViewCell else { return  UICollectionViewCell() }
            
            let url = URL(string: MoviesAPIURL.image.rawValue + (movieDetail.poster_path ?? ""))
            let data = try? Data(contentsOf: url!)
            cell.imagePoster.image = UIImage(data: data!)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatedCollectionViewCell", for: indexPath) as? MovieRatedCollectionViewCell
            cell?.imagePoster.image = UIImage(named: "depp")
            return cell ?? UICollectionViewCell()
        }
    }
}
