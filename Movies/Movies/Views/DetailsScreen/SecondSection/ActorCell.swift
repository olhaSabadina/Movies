//
//  ActorCell.swift
//  Movies
//
//  Created by Olga Sabadina on 25.01.2024.
//

import SDWebImage
import AsyncDisplayKit

class ActorCell: ASCellNode {
    
    let actorModel: ActorModel
    let actorPhoto = ASImageNode()
    let actorName = ASTextNode()
    let filmName = ASTextNode()
    
    init(actorModel: ActorModel) {
        self.actorModel = actorModel
        super.init()
        setCell()
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
     
        let image = ASInsetLayoutSpec(insets: .zero, child: actorPhoto)
        
        let textStack = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .center, children: [actorName, filmName])
        let textInset = ASInsetLayoutSpec(insets: .init(top: 7, left: 9, bottom: 7, right: 9), child: textStack)
        
        let cellStack = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [image, textInset])
    
        return cellStack
    }
    
    private func setCell() {
        let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
        let attributesName: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle]
        let attributesFilm: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.gray,
            .paragraphStyle: paragraphStyle]
        
        //TODO: загрузку используя вебимедж
        actorPhoto.image = UIImage(systemName: actorModel.photo)
        actorPhoto.backgroundColor = .yellow
        actorPhoto.style.height = .init(unit: .points, value: 113)
        actorPhoto.style.width = .init(unit: .points, value: 82)
        actorPhoto.contentMode = .scaleAspectFill
        actorPhoto.cornerRadius = 3
        actorName.attributedText = .init(string: actorModel.name, attributes: attributesName)
        filmName.attributedText = .init(string: actorModel.filmName, attributes: attributesFilm)
        
    }
}

