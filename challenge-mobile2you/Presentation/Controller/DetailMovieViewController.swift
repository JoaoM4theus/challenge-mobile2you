//
//  ViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 21/09/21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var likesMovieLabel: UILabel!
    @IBOutlet weak var popularityMovieLabel: UILabel!
    var favorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimilarMovieCell", bundle: nil), forCellReuseIdentifier: "ReuseCell")
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
