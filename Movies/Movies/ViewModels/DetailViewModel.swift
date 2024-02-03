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
    
    init(model: MovieCellModel) {
        self.model = model
        fetchMovieModel()
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
    
}
