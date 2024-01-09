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
        }
    }
    
    var segmentControlInHeader: CustomSegment? {
        switch self {
        case .categories:
            return nil
        case .popular:
            return createHeaderSegment()
        case .freeWatch:
            return createHeaderSegment()
        case .latestTrailers:
            return createHeaderSegment()
        }
    }
    
    
    private func createHeaderSegment() -> CustomSegment {
        return CustomSegment()
    }
    
}

class HomeViewModel {
    
    func nuberOfSection() -> Int {
        HomeSectionType.allCases.count
    }
    
    func numberItemsInSections(section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 7
        default:
            return 0
        }
    }
    
}
