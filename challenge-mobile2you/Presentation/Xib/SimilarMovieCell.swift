//
//  similarMovieCell.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 22/09/21.
//

import UIKit

class SimilarMovieCell: UITableViewCell {
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var dateMovieLabel: UILabel!
    @IBOutlet weak var genreMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
