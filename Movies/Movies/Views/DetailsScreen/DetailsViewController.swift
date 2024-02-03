//
//  DetailsViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 23.02.2024.
//

import AsyncDisplayKit
import AVKit
import AVFoundation
import Combine

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
    
    let viewModel: DetailViewModel
    var mainSection: MainSection
    let secondSection: SecondSection
    let thirdSection: ThirdTableSection
    let socialsSection: SocialTable
    let mediaSection: MediaSectionNode
    var recomendationSection: RecomendationSection
    var cancellable = Set<AnyCancellable>()
    
    init(model: MovieCellModel = .init(imageUrl: "", title: "Empty")) {
        self.viewModel = DetailViewModel(model: model)
        mainSection = MainSection(headerData: mocHeaderDataDetail)
        secondSection = SecondSection(typeBtn: .simple, sectionData: mocActorsDataModel)
        thirdSection = ThirdTableSection(movies: dataForThirdSection, sectionTitle: "Current Season")
        socialsSection = SocialTable(socials: mocForSocialSection)
        mediaSection = MediaSectionNode(media: mocForMedia)
        recomendationSection = RecomendationSection(movies: viewModel.recommendations)
        super.init(node: rootNode)

        title = viewModel.model.title
        
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
        sinkToProperties()
        mainSection.videoCell.delegatePlayVideo = self
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
    
    private func sinkToProperties() {
        viewModel.$headerData.sink { model in
            guard let model else {return}
            self.mainSection = MainSection(headerData: model)
            self.rootNode.setNeedsLayout()
        }
        .store(in: &cancellable)
        
        viewModel.$isLoadData.sink { isLoad in
            print(self.viewModel.recommendations.count)
            self.recomendationSection = RecomendationSection(movies: self.viewModel.recommendations)
            self.rootNode.setNeedsLayout()
        }
        .store(in: &cancellable)
    }
}

extension DetailsViewController: ActorInfo {
    func didOpenActorInfo(_ actor: ActorModel) {
        navigationItem.backButtonTitle = ""
        let actorVC = ActorsViewController(actorModel: actor)
        navigationController?.pushViewController(actorVC, animated: true)
    }
}

extension DetailsViewController: PlayVideo {
    func didTapPlayButton() {
        viewModel.fetchVideoUrl { youtubeId in
        
            if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
               UIApplication.shared.canOpenURL(youtubeURL) {
                // redirect to app
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
                // redirect through safari
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            }
            
        }
    }
}

