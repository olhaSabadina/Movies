//
//  DetailViewModel.swift
//  Movies
//
//  Created by Olga Sabadina on 03.02.2024.
//

import Foundation
import Combine

class DetailViewModel {
    
    @Published var error: Error?
    let model: MovieCellModel
    var cancellable = Set<AnyCancellable>()
    @Published var headerData: MainSectionModel?
    @Published var recommendations = [MovieCellModel]()
    @Published var isLoadData = false
    private let networkManager = NetworkManager()
    
    init(model: MovieCellModel) {
        self.model = model
        fetchMovieModel()
        fetchRecommendationMovies()
    }
    
    func fetchMovieModel() {
        print(UrlCreator.movie(id: model.idMovie ?? 0), "__--___--___--url model movie")
        NetworkManager().fetchMovies(urlString: UrlCreator.movie(id: model.idMovie ?? 0), type: MovieModel.self)
            .sink { сompletion in
                switch сompletion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                    print(error.localizedDescription, "fetchMovieModel")
                }
            } receiveValue: { movie in
                self.createMovieModel(movie)
            }
            .store(in: &cancellable)
    }
    
    private func createMovieModel(_ movie: MovieModel ) {
        let mainSectionModel = MainSectionModel(titleName: model.title, duration: movie.runtime, channelTitle: movie.productionCompanies[0].name, percentTitle: model.percentTitle, yearMovie: movie.releaseDate, videoURLString: "https://www.w3schools.com/html/mov_bbb.mp4" /*UrlCreator.imageUrl(movie.posterPath)*/, genteType: movie.genresArray, descriptionHeader: movie.overview, percent: model.percent)
        self.headerData = mainSectionModel
    }
    
    func fetchRecommendationMovies() {
        print(UrlCreator.getRecommendationMovies(id: model.idMovie ?? 0), "yura")
        networkManager.fetchMovies(urlString: UrlCreator.getRecommendationMovies(id: model.idMovie ?? 0), type: MainResultsMovies.self)
            .sink { сompletion in
                switch сompletion {
                case .finished:
                    self.isLoadData = true
                case .failure(let error):
                    self.error = error
                    print(error.localizedDescription, "fetchMovieModel")
                }
            } receiveValue: { movies in
                print(movies.movies?.count ?? 9999)
                self.getAllRecommendations(movies)
            }
            .store(in: &cancellable)
    }
    
    private func getAllRecommendations(_ result: MainResultsMovies) {
        result.movies?.forEach{ movie in
            let model = MovieCellModel(imageUrl: UrlCreator.imageUrl(movie.posterPath ?? "") , title: movie.title ?? "", percent: Int((movie.voteAverage ?? 0)*10))
            self.recommendations.append(model)
        }
    }
}
