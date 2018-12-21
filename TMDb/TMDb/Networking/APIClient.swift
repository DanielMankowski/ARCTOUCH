//
//  APIClass.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientable {
    func getUpcomingMovies(page: Int?, completion: @escaping (UpcomingMovies?)->Void)
    func searchMovies(searchTerm: String, completion: @escaping (UpcomingMovies?)->Void)
}

final class APIClient: APIClientable  {
    
    var genres: GenresDescription?
    
    let urlImagesBase: String = "http://image.tmdb.org/t/p/w185"
    let urlUpcomingMovies: String = "https://api.themoviedb.org/3/movie/upcoming"
    let urlGenre: String = "https://api.themoviedb.org/3/genre/movie/list"
    let urlSearch: String = "https://api.themoviedb.org/3/search/movie"
    let queryAPIKey = URLQueryItem(name: "api_key", value: "1f54bd990f1cdfb230adb312546d765d")
    let queryLanguage = URLQueryItem(name: "language", value: "en-US")
    
    private func getGenres(completion: @escaping (GenresDescription?)->Void) {
        guard genres == nil else {
            completion(genres)
            return
        }
        guard var url = URLComponents(string: urlGenre) else { return }
        url.queryItems = [queryAPIKey, queryLanguage]
        
        AF.request(url, method: .get)
            .validate()
            .responseJSON { [weak self] response in
                guard let safeSelf = self else {
                    completion(nil)
                    return
                }
                switch response.result {
                case .success:
                    guard let jsonData = response.data else { return }
                    do {
                        let jsonDecoder = JSONDecoder()
                        safeSelf.genres = try jsonDecoder.decode(GenresDescription.self, from: jsonData)
                        completion(safeSelf.genres)
                    } catch {
                        print("Error: \(error)")
                    }
                case .failure:
                    break
                }
        }
    }
    
    func getUpcomingMovies(page: Int? = nil, completion: @escaping (UpcomingMovies?)->Void) {
        
        getGenres { [weak self] (genres) in
            guard let safeSelf = self else { return }
            guard var urlComponents = URLComponents(string: safeSelf.urlUpcomingMovies)
                else {
                    completion(nil)
                    return
            }
            
            var queryItems = [safeSelf.queryAPIKey, safeSelf.queryLanguage]
            if let page = page {
                let queryPage = URLQueryItem(name: "page", value: String(page))
                queryItems.append(queryPage)
            }
            urlComponents.queryItems = queryItems
            AF.request(urlComponents, method: .get)
                .validate()
                .responseJSON { response in
                    print (response.result)
                    switch response.result {
                    case .success:
                        guard let jsonData = response.data else {
                            completion(nil)
                            return
                        }
                        do {
                            let jsonDecoder = JSONDecoder()
                            let movies = try jsonDecoder.decode(UpcomingMovies.self, from: jsonData)
                            safeSelf.fillExtraData(movies.results)
                            completion(movies)
                        } catch {
                            print("Error: \(error)")
                        }
                        break
                    case .failure:
                        completion(nil)
                    }
            }
        }
    }
    
    func searchMovies(searchTerm: String, completion: @escaping (UpcomingMovies?)->Void) {
        guard var urlComponents = URLComponents(string: urlSearch)
            else {
                completion(nil)
                return
        }
        let querySearchTerm = URLQueryItem(name: "query", value: searchTerm)
        let queryItems = [queryAPIKey, queryLanguage, querySearchTerm]
        urlComponents.queryItems = queryItems
        
        AF.request(urlComponents, method: .get)
            .validate()
            .responseJSON { [weak self] response in
                guard let safeSelf = self else { return }
                print (response.result)
                switch response.result {
                case .success:
                    guard let jsonData = response.data else {
                        completion(nil)
                        return
                    }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let movies = try jsonDecoder.decode(UpcomingMovies.self, from: jsonData)
                        safeSelf.fillExtraData(movies.results)
                        completion(movies)
                    } catch {
                        print("Error: \(error)")
                    }
                    break
                case .failure:
                    completion(nil)
                }
        }
    }
    
    private func fillExtraData(_ movies: [Movie]) {
        movies.forEach({ (movie) in
            movie.genreIds.forEach({ (id) in
                let filterGenres = self.genres?.genres.filter({ (genre) -> Bool in
                    genre.id == id
                })
                guard let filterGenre = filterGenres?.first else { return }
                if movie.genreDetail.isEmpty {
                    movie.genreDetail = filterGenre.name
                } else {
                    movie.genreDetail += ", \(filterGenre.name)"
                }
                if let posterPath = movie.posterPath {
                    movie.urlImage = urlImagesBase + posterPath
                }
            })
            
        })
    }
}
