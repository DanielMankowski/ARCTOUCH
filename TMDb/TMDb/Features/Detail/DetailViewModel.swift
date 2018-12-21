//
//  DetailViewModel.swift
//  TMDb
//
//  Created by Daniel Mankowski on 18/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol DetailViewModelable {
    func setMovie(movie: Movie)
}

protocol DetailViewModelListener: class {
}

class DetailViewModel: ViewModel<DetailViewControllable>,
DetailViewModelable,
DetailViewControllerListener {
    
    var movie: Movie? {
        didSet {
            viewController.setupInterface()
        }
    }
    weak var listener: DetailViewModelListener?
    
    func getTitle() -> String {
        return movie?.title ?? ""
    }
    
    func getGenre() -> String {
        return movie?.genreDetail ?? ""
    }
    
    func getOverview() -> String {
        return movie?.overview ?? ""
    }
    
    func getReleaseDate() -> String {
        return movie?.releaseDate ?? ""
    }
    
    func urlImage() -> String {
        return movie?.urlImage ?? ""
    }
    
    func setMovie(movie: Movie) {
        self.movie = movie
    }
}
