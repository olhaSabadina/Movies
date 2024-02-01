// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? JSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int
    let results: [Results]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Results: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterFullPath: String {
        UrlCreator.imageUrl(posterPath)
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//https://image.tmdb.org/t/p/original/qhb1qOilapbapxWQn9jtRCMwXJF.jpg?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1

//"https://api.themoviedb.org/3/movie/popular?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"

enum UrlCreator: String {
    case baseForPoster = "https://image.tmdb.org/t/p/original"
    case apiKey = "?api_key=4eefc1a2e5e226c9176fb1fc2cd2a9d1"
    case base = "https://api.themoviedb.org/3/movie"
    case popular = "/popular"
    
    static func imageUrl(_ posterPath: String) -> String {
        var result = baseForPoster.rawValue + posterPath + apiKey.rawValue
        return result
    }
    
    static func popularMovies() -> String {
        base.rawValue + popular.rawValue + apiKey.rawValue
    }
}
