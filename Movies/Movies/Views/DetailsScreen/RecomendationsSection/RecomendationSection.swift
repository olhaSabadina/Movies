//
//  RecomendationSection.swift
//  Movies
//
//  Created by Olga Sabadina on 30.01.2024.
//

import AsyncDisplayKit

class RecomendationSection: ASDisplayNode {
    
    let headerTitle = ASTextNode()
    let collectionMovies: RecomendationCollection
        
    init(movies: [MovieCellModel], isRecomendation: Bool = true) {
        //self.isRecomendation = isRecomendation
        self.collectionMovies = RecomendationCollection(movies: movies, isRecomendation: isRecomendation)
        super.init()
        self.automaticallyManagesSubnodes = true
        setHeader()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
     
        let header = ASInsetLayoutSpec(insets: .init(), child: self.headerTitle)
        header.style.width = .init(unit: .fraction, value: 1)
        
        let collectionStack = ASInsetLayoutSpec(insets: .init(), child: self.collectionMovies)
        
        let sectionStack = ASStackLayoutSpec(direction: .vertical, spacing: 15, justifyContent: .start, alignItems: .start, children: [header, collectionStack])
        
        let stackInset = ASInsetLayoutSpec(insets: .init(top: 25, left: 16, bottom: 5, right: 5), child: sectionStack)
        
        return stackInset
    }
    
    private func setHeader() {
        let attributesBold: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.black]
        
        headerTitle.attributedText = .init(string: "Recomendations", attributes: attributesBold)
        collectionMovies.style.preferredLayoutSize = .init(width: ASDimensionAuto, height: ASDimensionMake(240))
    }
}
