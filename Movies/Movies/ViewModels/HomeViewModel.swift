//
//  HomeViewModel.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit
import Combine

class CustomSegment {}

enum HomeSectionType: Int, CaseIterable {
    case categories
    case popular
    case freeWatch
    case latestTrailers
    case trending
    
    var headerTitle: String? {
        switch self {
        case .categories:
            return nil
        case .popular:
            return "What's Popular"
        case .freeWatch:
            return "Free To Watch"
        case .latestTrailers:
            return "Latest Trailers"
        case .trending:
            return "Trending"
        }
    }
    
    var headersSegments: [String] {
        switch self {
        case .categories:
            return []
        case .popular:
            return ["Streming", "On TV", "For Rent", "In Theatres  "]
        case .freeWatch:
            return ["Movies", "TV Shows"]
        case .latestTrailers:
            return ["Streming", "On TV", "For Rent", "In Theatres "]
        case .trending:
            return ["Today", "This Week"]
        }
    }
    
    var segmentKeyForIndex: String {
        switch self {
        case .categories:
            return ""
        case .popular:
            return "popular"
        case .freeWatch:
            return "freeWatch"
        case .latestTrailers:
            return "latestTrailers"
        case .trending:
            return "trending"
        }
    }
}

class HomeViewModel {
    
    let categoriesTitle = ["Movies", "TV Shows", "People", "More"]
    let moviesTitle = ["Mare of Easttown", "Tom Clancy's wore", "Vanquish", "More", "Mare of Easttown", "Tom Clancy's wore", "Vanquish", "More", "Mare of Easttown"]
    let viewsPercent = ["90%", "75%", "8%", "55%", "90%", "75%", "8%", "55%","90%", "75%", "8%", "55%"]
    
    @Published var error: Error?
    @Published var popularMoviesArray: [MovieCellModel] = []
    @Published var trendingMoviesArray: [MovieCellModel] = []
    @Published var upcomingMoviesArray: [MovieCellModel] = []
    @Published var segmentSectionsIndex: [String:Int] = [:]
    @Published var seeAllSectionDictionary: [String:Bool] = [:]
    @Published var seeAllSectionType: HomeSectionType = .categories
    private let networkManager: NetworkProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
    init(_ networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        fatchPopularMovies()
        fatchFreeToWatchMovies()
        fatchTrendingMovies()
    }
    
    //MARK: - fatchPopularMovies
    
    private func fatchPopularMovies() {
        networkManager.fetchMovies(urlString: UrlCreator.popularMovies(), type: PopularMovies.self)
               .sink { сompletion in
                   switch сompletion {
                   case .finished:
                       break
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
    
    
    //MARK: - fatchTrendingMovies
    
    func fatchTrendingMovies(_ index: Int = 0) {
        let urlString = index == 0 ? UrlCreator.trendingForDayMovies() : UrlCreator.trendingForWeekMovies()
        networkManager.fetchMovies(urlString: urlString, type: TrendingMovies.self)
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
    
    private func createMoviesModelsArray(_ dataMovies: TrendingMovies) {
        let resultsArray = dataMovies.results
        trendingMoviesArray = []
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: Int(item.voteAverage*10), idMovie: item.id)
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
            return categoriesTitle.count
        case 1:
            return popularMoviesArray.count
        case 2:
            print(upcomingMoviesArray.count, "upcomingMoviesArray")
            return upcomingMoviesArray.count
        case 3:
            return 7
        case 4:
            return trendingMoviesArray.count
        default:
            return 0
        }
    }
    
    
    
    
    
}
