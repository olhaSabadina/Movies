//
//  ActorsViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 31.01.2024.
//

import AsyncDisplayKit
import AVKit
import AVFoundation

class ActorsViewController: ASDKViewController<ASScrollNode> {

    private let actorModel: ActorModel
    
    private let rootNode: ASScrollNode = {
       let rootNode = ASScrollNode()
        rootNode.automaticallyManagesSubnodes = true
        rootNode.backgroundColor = .white
        rootNode.scrollableDirections = [.down, .up]
        rootNode.automaticallyManagesContentSize = true
        rootNode.automaticallyRelayoutOnSafeAreaChanges = true
        rootNode.insetsLayoutMarginsFromSafeArea = false
        return rootNode
    }()
    
    let actorInfoSection: ActorInfoSection
    let knownForSection: RecomendationSection
    let actingSection: ActingSection
    
    init(actorModel: ActorModel) {
        self.actorModel = actorModel
        actorInfoSection = ActorInfoSection(model: actorModel)
        knownForSection = RecomendationSection(movies: mocForRecomendationSection, isRecomendation: false)
        actingSection = ActingSection(movies: mocForActingSection)
        
        super.init(node: rootNode)
        
        title = actorModel.name
        
        rootNode.layoutSpecBlock = { _,_ -> ASLayoutSpec in

            let headerInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 8, right: 0), child: self.actorInfoSection)
            
            let result = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                headerInset,
                self.knownForSection,
                self.actingSection
            ])
            
            return result
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        didSelectActingMovies()
    }
    
    private func didSelectActingMovies() {
        actingSection.actingTable.completionAction = {model in
            print(model.title)
        }
    }
}

