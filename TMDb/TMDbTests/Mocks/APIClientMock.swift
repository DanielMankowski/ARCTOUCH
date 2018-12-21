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
    var getUpcomingMoviesHandler: ((Int?, (UpcomingMovies?)->Void)->())? = nil
    var searchMoviesCallCount: Int = 0
    var searchMoviesHandler: ((String, (UpcomingMovies?)->Void)->())? = nil
    
    
    func getUpcomingMovies(page: Int?, completion: @escaping (UpcomingMovies?) -> Void) {
        getUpcomingMoviesCallCount += 1
        if let returnValue = getUpcomingMoviesHandler?(page, completion) { return returnValue }
    }
    
    func searchMovies(searchTerm: String, completion: @escaping (UpcomingMovies?) -> Void) {
        searchMoviesCallCount += 1
        if let returnValue = searchMoviesHandler?(searchTerm, completion) { return returnValue }
    }
}
