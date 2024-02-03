//
//  MainSectionModel.swift
//  Movies
//
//  Created by Olga Sabadina on 24.01.2024.
//

import Foundation

struct MainSectionModel {
    let titleName: String
    let duration: Int
    let channelTitle: String
    let percentTitle: String
    let yearMovie: String
    let videoURLString: String
    let genteType: [String]
    let descriptionHeader: String
    let percent: Int?
    
    var durationTitle: String {
        timeDuration(duration)
    }
    
    private func timeDuration(_ value: Int) -> String {
        var result = ""
        if value < 60 {
            result = "\(value)m"
        } else {
            result = calculateDuration(value)
        }
        return result
    }
    
    private func calculateDuration(_ duration: Int) -> String {
        let hours = duration / 60
        let minutes = duration - (hours * 60)
        return "\(hours)h \(minutes)m"
    }
}
