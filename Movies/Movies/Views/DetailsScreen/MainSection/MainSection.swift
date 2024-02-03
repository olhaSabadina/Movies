//
//  HeaderDetail.swift
//  Movies
//
//  Created by Olga Sabadina on 24.01.2024.
//

import AsyncDisplayKit

class MainSection: ASDisplayNode {
 
    let headerData: MainSectionModel
    let headerDetail: HeaderDetailName
    let videoCell: VideoCell
    let genreLabels: GenreMovie
    let buttonStack: ButtonsStack
    
    init(headerData: MainSectionModel) {
        self.headerData = headerData
        headerDetail = HeaderDetailName(headerData: headerData)
        videoCell = VideoCell(headerData.imageURL)
        genreLabels = GenreMovie(headerData)
       
        buttonStack = ButtonsStack(actionBtn: { btn in
            print(btn.title)
        })
        
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [self.headerDetail, self.videoCell, self.genreLabels, self.buttonStack ])
    }
}
