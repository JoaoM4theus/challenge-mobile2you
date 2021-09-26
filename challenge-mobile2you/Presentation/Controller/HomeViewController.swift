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
        
        getData()
    }
    
    func getData() {
        topRatedModel.getMovieTopRated()
        popularModel.getMoviePopular()
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
            return popularModel.configCell(collectionView: collectionView, indexPath: indexPath)
        }
        return topRatedModel.configCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionMoviePopularView {
            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailMovieViewController {
                vc.idMovie = self.popularModel.movie[indexPath.row].id
                present(vc, animated: true, completion: nil)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailMovieViewController {
                vc.idMovie = self.topRatedModel.movie[indexPath.row].id
                present(vc, animated: true, completion: nil)
            }
        }
    }
}
