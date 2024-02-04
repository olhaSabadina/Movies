//
//  HomeViewModel.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit
import Combine

class HomeViewModel {
    
    @Published var error: Error?
    @Published var shouldReloadCollection = false
    @Published var popularMoviesArray: [MovieCellModel] = []
    @Published var upcomingMoviesArray: [MovieCellModel] = []
    @Published var latestMoviesArray: [MovieCellModel] = []
    @Published var trendingMoviesArray: [MovieCellModel] = []
    @Published var segmentSectionsIndex: [String:Int] = [:]
    @Published var seeAllSectionDictionary: [String:Bool] = [:]
    @Published var seeAllSectionType: HomeSectionType = .categories
    private let networkManager: NetworkProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
    init(_ networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        fatchPopularMovies()
        fetchLatestMovies()
        fatchFreeToWatchMovies()
        fatchTrendingMovies()
    }
    
    //MARK: - fatchPopularMovies
    
    private func fatchPopularMovies() {
        networkManager.fetchMovies(urlString: UrlCreator.popularMovies(), type: PopularMovies.self)
               .sink { сompletion in
                   switch сompletion {
                   case .finished:
                       self.shouldReloadCollection = true
                   case .failure(let error):
                       self.error = error
                       print(error.localizedDescription, "parse error")
                   }
               } receiveValue: { movies in
                   self.createMoviesModelsArray(movies)
               }
               .store(in: &cancellable)
       }
    
    private func createMoviesModelsArray(_ dataMovies: PopularMovies) {
        let resultsArray = dataMovies.results
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: Int(item.voteAverage*10), idMovie: item.id)
            popularMoviesArray.append(cellModel)
        }
    }
    
    //MARK: - "free to watch" TMDB don't have (i use upcoming api)
    
    private func fatchFreeToWatchMovies() {
        networkManager.fetchMovies(urlString: UrlCreator.upcomingMovies(), type: UpcomingMovies.self)
               .sink { сompletion in
                   switch сompletion {
                   case .finished:
                       break
                   case .failure(let error):
                       self.error = error
                       print(error.localizedDescription, "parse error upcomming")
                   }
               } receiveValue: { movies in
                   self.createMoviesModelsArray(movies)
               }
               .store(in: &cancellable)
       }
    
    private func createMoviesModelsArray(_ dataMovies: UpcomingMovies) {
        let resultsArray = dataMovies.results
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: Int(item.voteAverage*10), idMovie: item.id)
            upcomingMoviesArray.append(cellModel)
        }
    }
    
    //MARK: - LatestTrailers Sections
    
    private func fetchLatestMovies() {
        networkManager.fetchMovies(urlString: UrlCreator.nowPlayingMovies(), type: MainResultsMovies.self)
               .sink { сompletion in
                   switch сompletion {
                   case .finished:
                       break
                   case .failure(let error):
                       self.error = error
                       print(error.localizedDescription, "parse error latest Trailers")
                   }
               } receiveValue: { movies in
                   
                   self.latestMoviesArray = self.createMoviesArrayModels(movies)
               }
               .store(in: &cancellable)
       }
    
    private func createMoviesArrayModels(_ data: MainResultsMovies) -> [MovieCellModel] {
        guard let resultsArray = data.movies else {return []}
        
        var arrayMovies = [MovieCellModel]()
        
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: item.percent, idMovie: item.id)
            arrayMovies.append(cellModel)
        }
        
        return arrayMovies
    }
    
    
    //MARK: - TrendingMovies
    
    func fatchTrendingMovies(_ index: Int = 0) {
        let urlString = index == 0 ? UrlCreator.trendingForDayMovies() : UrlCreator.trendingForWeekMovies()
        networkManager.fetchMovies(urlString: urlString, type: MainResultsMovies.self)
               .sink { сompletion in
                   switch сompletion {
                   case .finished:
                       break
                   case .failure(let error):
                       self.error = error
                       print(error.localizedDescription, "parse error trending")
                   }
               } receiveValue: { movies in
                   self.createMoviesModelsArray(movies)
               }
               .store(in: &cancellable)
       }
    
    private func createMoviesModelsArray(_ dataMovies: MainResultsMovies) {
        guard let resultsArray = dataMovies.movies else {return}
        trendingMoviesArray = []
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: Int((item.voteAverage ?? 0)*10), idMovie: item.id)
            trendingMoviesArray.append(cellModel)
        }
    }
    
    //MARK: - builder of Sections
    
    func nuberOfSection() -> Int {
        HomeSectionType.allCases.count
    }
    
    func numberItemsInSections(section: Int) -> Int {
        switch section {
        case 0:
            return HomeSectionType.categoriesTitle.count
        case 1:
            return popularMoviesArray.count
        case 2:
            return upcomingMoviesArray.count
        case 3:
            return latestMoviesArray.count
        case 4:
            return trendingMoviesArray.count
        default:
            return 0
        }
    }
}
