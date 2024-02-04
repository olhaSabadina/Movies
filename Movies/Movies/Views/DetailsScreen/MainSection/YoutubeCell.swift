////
////  YoutubeCell.swift
////  Movies
////
////  Created by Yura Sabadin on 04.02.2024.
////
///
///
///
import YouTubeiOSPlayerHelper
import AsyncDisplayKit

class YoutubeCell: ASDisplayNode {
    let videoUrl: String
    let youTubePlayer = ASDisplayNode(viewBlock: { YTPlayerView() })
    let isMain: Bool
    
    init(_ videoUrl: String?, isMain: Bool = true) {
        self.videoUrl = videoUrl ?? ""
        self.isMain = isMain
        super.init()
        automaticallyManagesSubnodes = true
        setupVideoPlayer()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetSpec = ASInsetLayoutSpec(insets: .init(top: 5, left: 0, bottom: 10, right: 0), child: youTubePlayer)
        return insetSpec
    }
    
    private func setupVideoPlayer() {
        guard !videoUrl.isEmpty else { return }
        if let playerView = youTubePlayer.view as? YTPlayerView {
            playerView.load(withVideoId: videoUrl)
        }
        youTubePlayer.style.width = .init(unit: .fraction, value: 1)
        youTubePlayer.style.height = .init(unit: .points, value: isMain ? 230 : 140)
        youTubePlayer.style.flexShrink = 1
    }
}
