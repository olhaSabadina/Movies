//
//  UrlCreator.swift
//  Movies
//
//  Created by Olga Sabadina on 02.02.2024.
//

import Foundation

//https://image.tmdb.org/t/p/original/qhb1qOilapbapxWQn9jtRCMwXJF.jpg?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1

//"https://api.themoviedb.org/3/movie/popular?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"

//https://api.themoviedb.org/3/trending/movie/day?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1

//https://api.themoviedb.org/3/movie/upcoming?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1

//https://api.themoviedb.org/3/movie/787699/similar?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1  Similar

enum UrlCreator: String {
    case api = "&api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"
    case apiKey = "?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"
    case base = "https://api.themoviedb.org/3/movie"
    case popular = "/popular"
    case upcoming = "/upcoming"
    case recommendation = "/similar"
   
    
    case baseForPoster = "https://image.tmdb.org/t/p/original"
    case baseForTrending = "https://api.themoviedb.org/3/trending/movie"
    case trendingForDay = "/day"
    case trendingForWeek = "/week"
    
    static func imageUrl(_ posterPath: String?) -> String? {
        guard let posterPath else { return nil }
        return baseForPoster.rawValue + posterPath + apiKey.rawValue
    }
    
    static func popularMovies() -> String {
        base.rawValue + popular.rawValue + apiKey.rawValue
    }
    
    static func trendingForDayMovies() -> String {
        baseForTrending.rawValue + trendingForDay.rawValue + apiKey.rawValue
    }
    
    static func trendingForWeekMovies() -> String {
        baseForTrending.rawValue + trendingForWeek.rawValue + apiKey.rawValue
    }
    
    static func upcomingMovies() -> String {
        base.rawValue + upcoming.rawValue + apiKey.rawValue
    }
    
    static func movie(id: Int) -> String {
        base.rawValue + "/\(id)" + apiKey.rawValue
    }
    
    static func getRecommendationMovies(id movie: Int) -> String {
        base.rawValue + "/\(movie)" + recommendation.rawValue + apiKey.rawValue
    }
    
    static func findMovie(searchType: SearchCategories, query: String) -> String {
        searchType.searchHeader + "\(query)" + api.rawValue
    }
}

enum SearchCategories: String, CaseIterable {
    case movie
    case tv
    case person
    case company
    
    var searchHeader: String {
        switch self {
        case .movie:
            return "https://api.themoviedb.org/3/search/movie?query="
        case .tv:
            return "https://api.themoviedb.org/3/search/tv?query="
        case .person:
            return "https://api.themoviedb.org/3/search/person?query="
        case .company:
            return  "https://api.themoviedb.org/3/search/company?query="
        }
    }
}
