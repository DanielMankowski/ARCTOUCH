//
//  APIClientMock.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 20/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

@testable import TMDb

class APIClientMock: APIClientable {
    var getUpcomingMoviesCallCount: Int = 0
    var getUpcomingMoviesHandler: ((Int?, String?, (UpcomingMovies?)->Void)->())? = nil
    
    
    func getUpcomingMovies(page: Int? = nil, searchTerm: String?, completion: @escaping (UpcomingMovies?)->Void) {
        getUpcomingMoviesCallCount += 1
//        if let returnValue = getUpcomingMoviesHandler(page, searchTerm, completion)
    }
}
