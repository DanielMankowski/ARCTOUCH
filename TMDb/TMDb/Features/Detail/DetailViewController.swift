//
//  DetailViewController.swift
//  TMDb
//
//  Created by Daniel Mankowski on 18/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit

protocol DetailViewControllable {
    func setupInterface()
}

protocol DetailViewControllerListener: class {
    func getTitle() -> String
    func getGenre() -> String
    func getOverview() -> String
    func getReleaseDate() -> String
    func urlImage() -> String
}

class DetailViewController: ViewController, DetailViewControllable {
    
    weak var listener: DetailViewControllerListener?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    func setupInterface() {
        title = listener?.getTitle()
        nameLabel.text = listener?.getTitle()
        genreLabel.text = listener?.getGenre()
        releaseDateLabel.text = listener?.getReleaseDate()
        overviewLabel.text = listener?.getOverview()
        if let url = listener?.urlImage() {
            posterImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "movie_placeholder"))
        }
    }
}
