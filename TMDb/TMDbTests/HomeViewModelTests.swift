//
//  TMDbTests.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import XCTest
@testable import TMDb

class HomeViewModelTests: XCTestCase {
    
    let viewController = HomeViewControllerMock()
    let apiClient = APIClientMock()
    let viewModelListener = HomeViewModelListenerMock()
    var viewModel: HomeViewModel!

    override func setUp() {
        viewModel = HomeViewModel(viewController, apiClient: apiClient)
        viewModel.listener = viewModelListener
        apiClient.getUpcomingMoviesHandler = { (page, completion) in
            let movie = Movie()
            movie.title = "test"
            let movies = UpcomingMovies(results: [movie], page: 1, totalPages: 1, totalResults: 1)
            completion(movies)
        }
    }

    func testActivate() {
        //Given
        apiClient.getUpcomingMoviesCallCount = 0
        //When
        viewModel.activate()
        //Verify
        XCTAssertEqual(1, apiClient.getUpcomingMoviesCallCount)
    }
    
    func testNumberOfMovies() {
        //Given
        viewModel.activate()
        //When
        let numberOfMovies = viewModel.numberOfMovies()
        //Verify
        XCTAssertEqual(1, numberOfMovies)
    }
    
    func testgetMovie() {
        //Given
        viewModel.activate()
        //When
        let movie = viewModel.getMovie(index: IndexPath(row: 0, section: 0)) ?? Movie()
        //Verify
        XCTAssertEqual("test", movie.title)
    }

    func testdidTapCell() {
        //Given
        viewModelListener.presentDetailScreenCallCount = 0
        viewModel.activate()
        //When
        viewModel.didTapCell(index: IndexPath(row: 0, section: 0))
        //Verify
        XCTAssertEqual(1, viewModelListener.presentDetailScreenCallCount)
    }
    
    func testFetchMoviesWithQuery() {
        //Given
        viewModel.activate()
        apiClient.getUpcomingMoviesCallCount = 0
        //When
        viewModel.fetchMovies(query: nil)
        //Verify
        XCTAssertEqual(1, apiClient.getUpcomingMoviesCallCount)
    }
    
    func testFetchMoviesWithoutQuery() {
        //Given
        viewModel.activate()
        apiClient.searchMoviesCallCount = 0
        //When
        viewModel.fetchMovies(query: "not empty")
        //Verify
        XCTAssertEqual(1, apiClient.searchMoviesCallCount)
    }
    
    func isLoadingCellIsTrue() {
        //Given
        viewModel.activate()
        //When
        let result = viewModel.isLoadingCell(for: IndexPath(row: 2, section: 0))
        //Verify
        XCTAssertTrue(result)
    }
    
    func isLoadingCellIsFalse() {
        //Given
        viewModel.activate()
        //When
        let result = viewModel.isLoadingCell(for: IndexPath(row: 1, section: 0))
        //Verify
        XCTAssertFalse(result)
    }
}
