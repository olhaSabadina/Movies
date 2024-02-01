//
//  MediaCell.swift
//  Movies
//
//  Created by Olga Sabadina on 26.01.2024.
//

import AsyncDisplayKit

class MediaCell: ASCellNode {
    
    var model: MediaModelCell
    var imageNode: ASNetworkImageNode
    let playButton = ASImageNode()
    
    init(model: MediaModelCell) {
        self.model = model
        imageNode = ASNetworkImageNode()
        super.init()
        self.automaticallyManagesSubnodes = true
        setImage()
        setButton()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = 1//16/9
            let imageRatioSpec = ASRatioLayoutSpec(ratio:ratio, child:self.imageNode)
        
        let buttonIns = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: playButton)
        
        return ASOverlayLayoutSpec(child: imageRatioSpec, overlay: buttonIns)
        }
    
    private func setImage() {
        imageNode.style.width = .init(unit: .fraction, value: 1)
        imageNode.style.height = .init(unit: .points, value: 230)
        imageNode.style.flexShrink = 1
        imageNode.shouldRenderProgressImages = true
        imageNode.contentMode = .scaleAspectFill
        imageNode.clipsToBounds = true
        guard let poster = model.moviePoster else {return}
        imageNode.url = URL(string: poster)
    }
    
    private func setButton() {
        playButton.cornerRadius = 30
        playButton.style.preferredSize = .init(width: 60, height: 60)
        playButton.image = UIImage(named: "play")
    }
}
