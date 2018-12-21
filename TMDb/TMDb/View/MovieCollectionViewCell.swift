//
//  MovieCollectionViewCell.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieCollectionViewCell"
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            nameLabel.text = model.name
            genreLabel.text = model.genre
            releaseDateLabel.text = model.releaseDate
            posterImageView.sd_setImage(with: URL(string: model.urlImage), placeholderImage: UIImage(named: "movie_placeholder")) { (_, _, _, _) in
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }

    private func setShadow() {
        //Set shadow to collection card
        self.layer.shadowRadius = 4.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
    
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.layer.masksToBounds = true
    }
}

extension MovieCollectionViewCell {
    struct Model {
        let name: String
        let genre: String
        let releaseDate: String
        let urlImage: String
        
        init(movie: Movie) {
            urlImage = movie.urlImage
            name = movie.title
            releaseDate = movie.releaseDate
            genre = movie.genreDetail
        }
    }
}
