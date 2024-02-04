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
    var secondSection: SecondSection
    let thirdSection: ThirdTableSection
    let socialsSection: SocialTable
    var mediaSection: MediaSectionNode
    var recomendationSection: RecomendationSection
    var cancellable = Set<AnyCancellable>()
    
    init(model: MovieCellModel = .init(imageUrl: "", title: "Empty")) {
        self.viewModel = DetailViewModel(model: model)
        mainSection = MainSection(headerData: mocHeaderDataDetail)
        secondSection = SecondSection(typeBtn: .simple, sectionData: mocForActingSection)
        thirdSection = ThirdTableSection(movies: dataForThirdSection, sectionTitle: "Current Season")
        socialsSection = SocialTable(socials: mocForSocialSection)
        mediaSection = MediaSectionNode(media: mocForActingSection)
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
        secondSection.collectionActor.openActorInfoDelegate = self
        sinkToProperties()
    }
    
    private func playVideo() {
        mediaSection.completionAction = { id in
            let vc = VideoViewController(movieID: id)
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    private func sinkToProperties() {
        viewModel.$isLoadData
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { isLoad in
                self.mainSection = MainSection(headerData: self.viewModel.headerData)
                self.secondSection = SecondSection(typeBtn: .simple, sectionData: self.viewModel.castArray, delegate: self)
                self.recomendationSection = RecomendationSection(movies: self.viewModel.recommendations, delegate: self)
                self.mediaSection = MediaSectionNode(media: self.viewModel.mediaSection)
                self.playVideo()
                self.rootNode.setNeedsLayout()
            }
            .store(in: &cancellable)
    }
}

extension DetailsViewController: ActorInfo {
    func didOpenActorInfo(_ actor: MovieCellModel) {
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

extension DetailsViewController: DetailMovieDelegate {
    func openDetailScreen(_ model: MovieCellModel) {
        let vc = DetailsViewController(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}

