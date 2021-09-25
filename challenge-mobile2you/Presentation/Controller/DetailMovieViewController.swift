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
    
    var favorite = false
    var movieDetailModel: MovieDetailModel = MovieDetailModel()
    var movieSimilarModel: MovieSimilarModel = MovieSimilarModel()
    var genreModel: GenresViewModel = GenresViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configShadow()
        genreModel.getGenres()
        movieDetailModel.delegate = self
        movieSimilarModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimilarMovieCell", bundle: nil), forCellReuseIdentifier: "ReuseCell")
        movieDetailModel.getMovieDetail(500)
        movieSimilarModel.getMovieSimilar(500)
    }
    
    func configShadow() {
        viewShadow.clipsToBounds = false
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 0.5
//        viewShadow.layer.shadowOffset = CGSize.zero
//        viewShadow.layer.shadowRadius = 10
        viewShadow.layer.shadowPath = UIBezierPath(roundedRect: viewShadow.bounds, cornerRadius: 10).cgPath
    }
    
    func configDetailMovie() {
        let url = URL(string: MoviesAPIURL.image.rawValue + (self.movieDetailModel.movie?.poster_path ?? ""))
        let data = try? Data(contentsOf: url!)
        self.imagePoster.image = UIImage(data: data!)
        self.nameMovieLabel.text = self.movieDetailModel.movie!.title
        self.likesMovieLabel.text = "\(self.movieDetailModel.movie!.vote_count) likes"
        self.popularityMovieLabel.text = "\(self.movieDetailModel.movie!.vote_average) popularity"
    }
    
    @IBAction func favoriteMovie(_ sender: UIButton) {
        let imageString = favorite ? "suit.heart" : "suit.heart.fill"
        favorite = !favorite
        sender.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSimilarModel.movieSimilar?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieDetail = movieSimilarModel.movieSimilar?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell") as! SimilarMovieCell
        let url = URL(string: MoviesAPIURL.image.rawValue + (movieDetail.poster_path ?? ""))
        let data = try? Data(contentsOf: url!)
        cell.imagePoster.image = UIImage(data: data!)
        cell.nameMovieLabel.text = movieDetail.title
        
        let date = Resources.dateFormatter.date(from: movieDetail.release_date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        cell.dateMovieLabel.text = formatter.string(from: date ?? Date())
        
        if movieDetail.genre_ids.count > 1 {
            cell.genreMovieLabel.text = genreModel.getGenreName(id: movieDetail.genre_ids[0], second: movieDetail.genre_ids[1])
        } else {
            cell.genreMovieLabel.text = genreModel.getGenreName(id: movieDetail.genre_ids[0])
        }
        
        return cell
    }
    
}

extension DetailMovieViewController: MovieDetailDelegate {
    func failFetchMovieDetail() {
        print("erro")
    }
    
    func finishFetchMovieDetail() {
        DispatchQueue.main.async {
            self.configDetailMovie()
        }
    }
}

extension DetailMovieViewController: MovieSimilarDelegate {
    func finishFetchMovieSimilar() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loading() {
        showActivity()
    }
    
    func finishLoading() {
        hideActivity()
    }
}
