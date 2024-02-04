//
//  MoviesCellModel.swift
//  Movies
//
//  Created by Olga Sabadina on 25.01.2024.
//

import Foundation


struct MovieCellModel {
    let imageUrl: String?
    let title: String?
    let description: String?
    let percent: Int?
    let asHeroInFilm: String?
    let yearEnterMovie: Int?
    let idMovie: Int?
    var imageFullHDUrl: String?
    let releaseData: String?
    
    var percentTitle: String {
        guard let percent else {return ""}
        return "\(percent)%"
    }
        
    init(imageUrl: String? = nil, title: String? = nil, description: String? = nil, percent: Int? = nil, asHeroInFilm: String? = nil, yearEnterMovie: Int? = nil, idMovie: Int? = nil, imageFullHDUrl: String? = nil, releaseData: String? = nil) {
        self.imageUrl = imageUrl
        self.title = title
        self.description = description
        self.percent = percent
        self.asHeroInFilm = asHeroInFilm
        self.yearEnterMovie = yearEnterMovie
        self.idMovie = idMovie
        self.imageFullHDUrl = imageFullHDUrl
        self.releaseData = releaseData
    }
}
