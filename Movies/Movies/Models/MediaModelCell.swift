//
//  MediaModelCell.swift
//  Movies
//
//  Created by Olga Sabadina on 26.01.2024.
//

import Foundation

struct MediaModelCell {
    let movieUrl: String
    let moviePoster: String?
    
    init(movieUrl: String, moviePoster: String? = nil) {
        self.movieUrl = movieUrl
        self.moviePoster = moviePoster
    }
}
