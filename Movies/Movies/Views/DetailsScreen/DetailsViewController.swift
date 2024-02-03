//
//  DetailsViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 23.02.2024.
//

import AsyncDisplayKit
import AVKit
import AVFoundation

class DetailsViewController: ASDKViewController<ASScrollNode> {
    
    private let rootNode: ASScrollNode = {
       let rootNode = ASScrollNode()
        rootNode.automaticallyManagesSubnodes = true
        rootNode.backgroundColor = .white
        rootNode.scrollableDirections = [.down, .up]
        rootNode.automaticallyManagesContentSize = true
        rootNode.automaticallyRelayoutOnSafeAreaChanges = true
        rootNode.insetsLayoutMarginsFromSafeArea = true
        return rootNode
    }()
    
    let model: MovieCellModel
    let mainSection: MainSection
    let secondSection: SecondSection
    let thirdSection: ThirdTableSection
    let socialsSection: SocialTable
    let mediaSection: MediaSectionNode
    let recomendationSection: RecomendationSection
    
    init(model: MovieCellModel = .init(imageUrl: "", title: "Empty")) {
        self.model = model
        mainSection = MainSection(headerData: mocHeaderDataDetail)
        secondSection = SecondSection(typeBtn: .simple, sectionData: mocActorsDataModel)
        thirdSection = ThirdTableSection(movies: dataForThirdSection, sectionTitle: "Current Season")
        socialsSection = SocialTable(socials: mocForSocialSection)
        mediaSection = MediaSectionNode(media: mocForMedia)
        recomendationSection = RecomendationSection(movies: mocForRecomendationSection)
        super.init(node: rootNode)

        title = model.title
        
        rootNode.layoutSpecBlock = { _,_ -> ASLayoutSpec in
    
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                self.mainSection,
                self.secondSection,
                self.thirdSection,
                self.socialsSection,
                self.mediaSection,
                self.recomendationSection
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        playVideo()
        secondSection.collectionActor.openActorInfoDelegate = self
    }
    
    private func playVideo() {
        mediaSection.completionAction = { url in
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
}

extension DetailsViewController: ActorInfo {
    func didOpenActorInfo(_ actor: ActorModel) {
        navigationItem.backButtonTitle = ""
        let actorVC = ActorsViewController(actorModel: actor)
        navigationController?.pushViewController(actorVC, animated: true)
    }
}

