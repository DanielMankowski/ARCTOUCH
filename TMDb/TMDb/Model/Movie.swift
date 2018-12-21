//
//  Movie.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

class Movie: Decodable {
    var id: Int = -1
    var title: String = ""
    var genreIds: [Int] = [Int]()
    var genreDetail = ""
    var releaseDate: String = ""
    var overview: String = ""
    var posterPath: String?
    var urlImage: String = ""
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
    }
}
