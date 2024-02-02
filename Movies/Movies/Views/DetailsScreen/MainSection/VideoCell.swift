//
//  VideoCell.swift
//  Movies
//
//  Created by Olga Sabadina on 24.01.2024.
//

import AsyncDisplayKit

class VideoCell: ASDisplayNode {
    let videoUrl: String
    let videoNode = ASVideoNode()
    let playButton = ASButtonNode()
    
    init(_ videoUrl: String, inMediaSection: Bool = false) {
        self.videoUrl = videoUrl
        super.init()
        self.automaticallyManagesSubnodes = true
        setVideo(inMediaSection)
        setButton()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let buttonIns = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: playButton)
        
        return ASOverlayLayoutSpec(child: videoNode, overlay: buttonIns)
    }
    
    private func setVideo(_ inMediaSection: Bool) {
        guard let url = URL(string: videoUrl) else {return}
        if inMediaSection {
            videoNode.url = url
        } else {
            let asset = AVAsset(url: url)
            videoNode.asset = asset
        }
        videoNode.shouldAutoplay = false
        videoNode.shouldAutorepeat = false
        videoNode.delegate = self
        
        videoNode.style.width = .init(unit: .fraction, value: 1)
        videoNode.style.height = .init(unit: .points, value: 230)
        videoNode.style.flexShrink = 1
    }
    
    private func setButton() {
        playButton.cornerRadius = 30
        playButton.style.preferredSize = .init(width: 60, height: 60)
        playButton.setImage(UIImage(named: "play"), for: .normal)
    }
        
}

extension VideoCell: ASVideoNodeDelegate {
    func videoNode(_ videoNode: ASVideoNode, willChange state: ASVideoNodePlayerState, to toState: ASVideoNodePlayerState) {
        
        playButton.isHidden = videoNode.isPlaying()
        
    }
}
