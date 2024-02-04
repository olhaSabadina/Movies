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
        networkManager.fetchMovies(urlString: UrlCreator.movie(id: model.idMovie ?? 0), type: Movie.self)
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
    
    private func createMovieModel(_ movie: Movie ) {
        
        fetchVideoUrl { key in
            print(key, "KEY!!!")
            self.headerData = MainSectionModel(titleName: movie.title,
                                               duration: movie.runtime,
                                               channelTitle: movie.nameChannel,
                                               percentTitle: self.model.percentTitle,
                                               yearMovie: movie.releaseDate,
                                               videoURLString: key /*"https://www.w3schools.com/html/mov_bbb.mp4"*/,
                                               genteType: movie.genresArray,
                                               descriptionHeader: movie.overview,
                                               percent: self.model.percent,
                                               imageURL: UrlCreator.imageUrl(movie.posterPath)
            )
        }
        
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
            let model = MovieCellModel(imageUrl: UrlCreator.imageUrl(movie.posterPath ?? "") , title: movie.title , percent: Int((movie.voteAverage ?? 0)*10))
            self.recommendations.append(model)
        }
    }
    
    func fetchVideoUrl(completion: @escaping (String)-> Void) {
        
        guard let id = model.idMovie else {return}
        print(UrlCreator.videoKey(for: id), "URLVideo")
        networkManager.fetchMovies(urlString: UrlCreator.videoKey(for: id), type: VideoModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { model in
                let key = self.videoKeyUrl(model: model)
                completion(key)
            }
            .store(in: &cancellable)
    }
    
    func videoKeyUrl(model: VideoModel) -> String {
        guard let key = model.results.first?.key else {return ""}
        return key
    }
}
