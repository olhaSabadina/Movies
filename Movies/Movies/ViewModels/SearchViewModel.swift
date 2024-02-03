//
//  SearchViewModel.swift
//  Movies
//
//  Created by Olga Sabadina on 03.02.2024.
//

import Foundation
import Combine

class SearchViewModel {
    
    @Published var error: Error?
    var trendingArray = [MovieCellModel]()
    var models = [MovieCellModel]()
    @Published var isShouldReloadTable = false
    var cancellable = Set<AnyCancellable>()
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        NetworkManager().fetchMovies(urlString: UrlCreator.trendingForWeekMovies(), type: TrendingMovies.self)
            .sink { сompletion in
                switch сompletion {
                case .finished:
                    self.isShouldReloadTable = true
                case .failure(let error):
                    self.error = error
                    print(error.localizedDescription, "SearchMovie")
                }
            } receiveValue: { movie in
                self.createSearchMovieModel(movie)
            }
            .store(in: &cancellable)
    }
    
    private func createSearchMovieModel(_ movie: TrendingMovies) {
        let results = movie.results
        results.forEach { item in
            let searchModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, description: item.overview, idMovie: item.id)
            trendingArray.append(searchModel)
        }
    }
    
}
