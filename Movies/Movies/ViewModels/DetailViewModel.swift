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

    @Published var isLoadData = false
    
    var headerData: MainSectionModel = .init()
    var castArray = [MovieCellModel]()
    var recommendations = [MovieCellModel]()
    var mediaSection = [MovieCellModel]()
    
    private var cancellable = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    
    init(model: MovieCellModel) {
        self.model = model
        fetchMovieModel()
        fetchRecommendationMovies()
        Task{
           try await createMoviesArrayModels()
        }
    }
    
    private func fetchMovieModel() {
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
                self.isLoadData = true
            }
            .store(in: &cancellable)
    }
    
    private func createMovieModel(_ movie: Movie ) {
        fetchVideoUrl { key in
            self.headerData = MainSectionModel(titleName: movie.title,
                                               duration: movie.runtime,
                                               channelTitle: movie.nameChannel,
                                               percentTitle: self.model.percentTitle,
                                               yearMovie: movie.releaseDate,
                                               videoURLString: key,
                                               genteType: movie.genresArray,
                                               descriptionHeader: movie.overview,
                                               percent: self.model.percent,
                                               imageURL: UrlCreator.imageUrl(movie.posterPath)
            )
        }
        
    }
    
    private func fetchRecommendationMovies() {
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
                self.getAllRecommendations(movies)
            }
            .store(in: &cancellable)
    }
    
    private func getAllRecommendations(_ result: MainResultsMovies) {
        result.movies?.forEach{ movie in
            let model = MovieCellModel(imageUrl: UrlCreator.imageUrl(movie.posterPath), title: movie.title, percent: movie.percent, idMovie: movie.id)
            self.recommendations.append(model)
        }
    }
    
    func fetchVideoUrl(completion: @escaping (String)-> Void) {
        
        guard let id = model.idMovie else {return}

        networkManager.fetchMovies(urlString: UrlCreator.videoKey(for: id), type: VideoModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { model in
                guard let key = model.results.first?.key else {return}
                completion(key)
            }
            .store(in: &cancellable)
    }
    
    func fetchCastMovies() {
        
        guard let id = model.idMovie else {return}
        
        networkManager.fetchMovies(urlString: UrlCreator.castMovie(id: id), type: CastModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoadData = true
                case .failure( let error):
                    print(error.localizedDescription, "fetchCastMovie error")
                    self.error = error
                }
            } receiveValue: { cast in
                self.castArray =  self.getAllCast(cast)
            }
            .store(in: &cancellable)
    }
    
    private func getAllCast(_ result: CastModel) -> [MovieCellModel] {
        var arrayCasts = [MovieCellModel]()
        for item in result.cast {
            let cellModel = MovieCellModel(imageUrl: UrlCreator.imageUrl(item.profilePath), title: item.name, asHeroInFilm: item.character)
            arrayCasts.append(cellModel)
        }
        return arrayCasts
    }
    
    private func createMoviesArrayModels() async throws {
        
        guard let id = model.idMovie else {return}
        
        var arrayMovies = [MovieCellModel]()
        
        let imageUrl = try await getImageURLPath(id: id)
        
        let cellModel = MovieCellModel(idMovie: id, imageFullHDUrl: imageUrl)
        
        arrayMovies.append(cellModel)
        
        self.mediaSection = arrayMovies
        self.isLoadData = true
    }
    
    private func getImageURLPath(id: Int?) async throws -> String? {
        
        guard let id, let urlString = URL(string: UrlCreator.imageMovie(id: id)) else { throw URLError(.badURL)}
        let (data, _) = try await URLSession.shared.data(from: urlString)
        
        let imageModels = try JSONDecoder().decode(ImageFullModel.self, from: data)
        let item = imageModels.backdrops.first { item in
            item.height < 1100
        }
        return UrlCreator.imageUrl(item?.filePath)
    }
}
