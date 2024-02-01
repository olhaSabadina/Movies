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
    @Published var segmentSectionsIndex: [String:Int] = [:]
    @Published var seeAllSectionDictionary: [String:Bool] = [:]
    @Published var seeAllSectionType: HomeSectionType = .categories
    private let networkManager: NetworkProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
    init(_ networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        fatchMovies()
    }
    
    private func fatchMovies() {
        networkManager.fetchMovies(urlString: UrlCreator.popularMovies(), type: Movies.self)
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
    
    private func createMoviesModelsArray(_ dataMovies: Movies) {
        let resultsArray = dataMovies.results
        resultsArray.forEach { item in
            let cellModel = MovieCellModel(imageUrl: item.posterFullPath, title: item.title, percent: Int(item.voteAverage*10))
            popularMoviesArray.append(cellModel)
        }
    }
       
    func nuberOfSection() -> Int {
        HomeSectionType.allCases.count
    }
    
    func numberItemsInSections(section: Int) -> Int {
        switch section {
        case 0:
            return categoriesTitle.count
        case 1: // what's Popular
            print(self.popularMoviesArray.count, "numberItemsInSections moviesArray.results.count")
            return popularMoviesArray.count
        case 2:
            return 5
        case 3:
            return 7
        case 4:
            return 5
        default:
            return 0
        }
    }
    
    
    
    
    
}
