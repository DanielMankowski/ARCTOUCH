//
//  HomeViewModel.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol HomeViewModelable {
    
}

protocol HomeViewModelListener: class {
    func presentDetailScreen(movie: Movie)
}

final class HomeViewModel: ViewModel<HomeViewControllable>,
HomeViewModelable,
HomeViewControllerListener {

    weak var listener: HomeViewModelListener?
    var genres: GenresDescription?
    var movies: [Movie] = [Movie]()
    var totalPages: Int = 0
    var searchQuery: String? = nil
    var totalMovies: Int = 0
    var page: Int = 0
    let apiClient: APIClientable
    
    init(_ viewController: HomeViewControllable,
         apiClient: APIClientable) {
        self.apiClient = apiClient
        super.init(viewController: viewController)
    }
    
    override func activate() {
        super.activate()
        apiClient.getUpcomingMovies(page: nil) { [weak self] (movies) in
            guard let safeSelf = self else { return }
            safeSelf.totalPages = movies?.totalPages ?? safeSelf.totalPages
            safeSelf.page = 2
            safeSelf.totalMovies = movies?.totalResults ?? safeSelf.totalMovies
            if let delta = movies?.results {
                safeSelf.movies.append(contentsOf: delta)
            }
            safeSelf.viewController.updateCollection(indexes: nil)
        }
    }
    
    func numberOfMovies() -> Int {
        return totalMovies
    }
    
    func getMovie(index: IndexPath) -> Movie? {
        return movies[index.row]
    }
    
    func didTapCell(index: IndexPath) {
        let movie = movies[index.row]
        listener?.presentDetailScreen(movie: movie)
    }
    
    func fetchMovies(query: String?) {
        if searchQuery != query {
            page = 1
            searchQuery = query
            movies.removeAll()
        }
        if (query == nil) {
             getUpcomingMovies()
        } else {
            guard let query = query else { return }
            getSearchedMovies(searchTerm: query)
        }
        
        
    }
    
    func isLoadingCell(for index: IndexPath) -> Bool {
        return index.row >= movies.count
    }
    
    private func getSearchedMovies(searchTerm: String) {
        apiClient.searchMovies(searchTerm: searchTerm) { [weak self] (movies) in
            guard let safeSelf = self else { return }
            safeSelf.page += 1
            safeSelf.totalPages = movies?.totalPages ?? safeSelf.totalPages
            safeSelf.totalMovies = movies?.totalResults ?? safeSelf.totalMovies
            if let movies = movies?.results {
                safeSelf.movies = movies
                safeSelf.viewController.updateCollection(indexes: nil)
            }
        }
    }
    
    private func getUpcomingMovies() {
        apiClient.getUpcomingMovies(page: page) { [weak self] (movies) in
            guard let safeSelf = self else { return }
            safeSelf.page += 1
            safeSelf.totalPages = movies?.totalPages ?? safeSelf.totalPages
            safeSelf.totalMovies = movies?.totalResults ?? safeSelf.totalMovies
            DispatchQueue.main.async {
                if let delta = movies?.results {
                    safeSelf.movies.append(contentsOf: delta)
                    safeSelf.viewController.updateCollection(indexes: safeSelf.calculateIndexPathsToReload(from: delta))
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath]? {
        guard movies.count != newMovies.count else { return nil }
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
