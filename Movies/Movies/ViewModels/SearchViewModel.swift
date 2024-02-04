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
    var trendingArray = [[MovieCellModel]]()
    var models = [[MovieCellModel]]()
    @Published var isShouldReloadTable = false
    var cancellable = Set<AnyCancellable>()
    let networkManager = NetworkManager()
    
    init() {
        fetchTrendingMovies()
    }
    
    func fetchTrendingMovies() {
        NetworkManager().fetchMovies(urlString: UrlCreator.trendingForWeekMovies(), type: MainResultsMovies.self)
            .sink { сompletion in
                switch сompletion {
                case .finished:
                    self.isShouldReloadTable = true
                case .failure(let error):
                    self.error = error
                    print(error.localizedDescription, "SearchMovie")
                }
            } receiveValue: { movie in
                self.trendingArray.append(self.createArrayMovieModels(movie, isTrending: true))
            }
            .store(in: &cancellable)
    }
    
    func findMovies(keyWord: String) {
        getAllSearhCategories(search: keyWord)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isShouldReloadTable = true
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { result in
                self.models = []
                result.forEach { item in
                    self.models.append(self.createArrayMovieModels(item))
                }
            }
            .store(in: &cancellable)
    }
    
    private func getAllSearhCategories(search: String) -> AnyPublisher<[MainResultsMovies],Error> {
        let categories = SearchCategories.allCases
        let publishers: [AnyPublisher<MainResultsMovies, Error>] = categories.map{findBySearchWord(searchType: $0, searchWord: search)}
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func findBySearchWord(searchType: SearchCategories, searchWord: String) -> AnyPublisher<MainResultsMovies,Error> {
        networkManager.fetchMovies(urlString: UrlCreator.findMovie(searchType: searchType, query: searchWord), type: MainResultsMovies.self)
    }
    
    private func createArrayMovieModels(_ movie: MainResultsMovies, isTrending: Bool = false) -> [MovieCellModel] {
        guard let results = movie.movies else {return []}
        
        var tempArray: [MovieCellModel] = []
        
        results.enumerated().forEach { index, item in
            if !isTrending {
                guard index < 3  else { return }
            }
                let searchModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, description: item.overview, percent: Int((item.voteAverage ?? 0)*10), idMovie: item.id)
                tempArray.append(searchModel)
        }
        return tempArray
    }
    
}
