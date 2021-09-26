//
//  ViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 21/09/21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    //MARK: - IBOulet
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var likesMovieLabel: UILabel!
    @IBOutlet weak var popularityMovieLabel: UILabel!
    
    var movieDetailModel: MovieDetailModel = MovieDetailModel()
    var movieSimilarModel: MovieSimilarModel = MovieSimilarModel()
    var idMovie: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    @IBAction func favoriteMovie(_ sender: UIButton) {
        movieDetailModel.favoriteButton(sender: sender)
    }
    
    func getData() {
        movieDetailModel.delegate = self
        movieSimilarModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimilarMovieCell", bundle: nil), forCellReuseIdentifier: "ReuseCell")
        movieDetailModel.getMovieDetail(idMovie ?? 550)
        movieSimilarModel.getMovieSimilar(idMovie ?? 550)
        movieSimilarModel.genres.getGenres()
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSimilarModel.movieSimilar?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        movieSimilarModel.configCell(tableView: tableView, indexPath: indexPath)
    }
}

extension DetailMovieViewController: MovieDetailDelegate {
    func failFetchMovieDetail() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops!", message: "An unexpected error happened. Movie Detail not found.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func finishFetchMovieDetail() {
        DispatchQueue.main.async {
            self.movieDetailModel.configDetailMovie(imagePoster: self.imagePoster, nameMovieLabel: self.nameMovieLabel, likesMovieLabel: self.likesMovieLabel, popularityMovieLabel: self.popularityMovieLabel, shadow: self.viewShadow)
        }
    }
}
extension DetailMovieViewController: MovieSimilarDelegate {
    func failFetchMovieSimiar() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops!", message: "An unexpected error happened. Movies Similar not found.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func finishFetchMovieSimilar() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loading() {
        showActivity()
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.hideActivity()
        }
    }
}
