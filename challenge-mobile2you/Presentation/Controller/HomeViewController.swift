//
//  HomeViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 25/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionMoviePopularView: UICollectionView!
    @IBOutlet weak var collectionMovieRatedView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMoviePopularView.delegate = self
        collectionMoviePopularView.dataSource = self
        collectionMovieRatedView.delegate = self
        collectionMovieRatedView.dataSource = self
//        collectionMovieRatedView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionMoviePopularView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePopularCollectionViewCell", for: indexPath) as? MoviePopularCollectionViewCell
            cell?.imagePoster.image = UIImage(named: "depp")
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatedCollectionViewCell", for: indexPath) as? MovieRatedCollectionViewCell
            cell?.imagePoster.image = UIImage(named: "depp")
            return cell ?? UICollectionViewCell()
        }
    }
    
    
}
