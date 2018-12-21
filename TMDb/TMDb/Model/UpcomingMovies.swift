//
//  Root.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

struct UpcomingMovies: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}

extension UpcomingMovies {
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
