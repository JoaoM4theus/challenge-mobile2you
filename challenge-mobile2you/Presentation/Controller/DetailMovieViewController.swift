//
//  ViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 21/09/21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    //MARK: - IBOulet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var likesMovieLabel: UILabel!
    @IBOutlet weak var popularityMovieLabel: UILabel!

    var favorite = false
    var movieDetailMovie: MovieDetailModel = MovieDetailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailMovie.delegate = self
        movieDetailMovie.getMovieDetail()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimilarMovieCell", bundle: nil), forCellReuseIdentifier: "ReuseCell")
    }
    
    func configDetailMovie() {
        let url = URL(string: MoviesAPIURL.image.rawValue + (self.movieDetailMovie.movie?.poster_path ?? ""))
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imagePoster.image = UIImage(data: data!)
                self.nameMovieLabel.text = self.movieDetailMovie.movie!.title
                self.likesMovieLabel.text = "\(self.movieDetailMovie.movie!.vote_count) likes"
                self.popularityMovieLabel.text = "\(self.movieDetailMovie.movie!.vote_average) popularity"
            }
        }
        
        
    }
    
    @IBAction func favoriteMovie(_ sender: UIButton) {
        let imageString = favorite ? "suit.heart" : "suit.heart.fill"
        favorite = !favorite
        sender.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell") as! SimilarMovieCell
        
        return cell
    }
    
}

extension DetailMovieViewController: MovieDetailDelegate {
    func finishFetchMovieDetail() {
        configDetailMovie()
    }
    
    
}
