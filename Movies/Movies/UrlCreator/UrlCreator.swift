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

enum UrlCreator: String {
    case apiKey = "?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"
    case base = "https://api.themoviedb.org/3/movie"
    case popular = "/popular"
    case upcoming = "/upcoming"
   
    
    case baseForPoster = "https://image.tmdb.org/t/p/original"
    
    case baseForTrending = "https://api.themoviedb.org/3/trending/movie"
    case trendingForDay = "/day"
    case trendingForWeek = "/week"
    
    static func imageUrl(_ posterPath: String) -> String {
        baseForPoster.rawValue + posterPath + apiKey.rawValue
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
    
}
