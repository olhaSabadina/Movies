//
//  SearchCell.swift
//  Movies
//
//  Created by Olga Sabadina on 23.01.2024.
//

import SDWebImage
import AsyncDisplayKit

class SearchCell: ASCellNode {
    
    let search: Search
    var isMain: Bool = false
    
    let bottomSeparator: ASDisplayNode
    let searchImage: ASImageNode
    let searchTitle: ASTextNode
    let searchDescription: ASTextNode
    
    init(search: Search, isMain: Bool) {
        self.search = search
        searchImage = ASImageNode()
        searchTitle = ASTextNode()
        searchDescription = ASTextNode()
        bottomSeparator = ASDisplayNode()
        self.isMain = isMain
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        setCell()
        downloadImage(urlString: search.imageUrl)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let searchImg = ASRatioLayoutSpec(ratio: 0.5, child: searchImage)
        
        var rightStack = ASLayoutSpec()
        
        if search.description != nil {
            rightStack = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [self.searchTitle, self.searchDescription])
            rightStack.style.flexShrink = 1
            
        } else {
            
            let insetBottom = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 15), child: self.bottomSeparator)
            rightStack = ASStackLayoutSpec(direction: .vertical, spacing: 15, justifyContent: .center, alignItems: .start, children: [self.searchTitle, insetBottom])
            rightStack.style.flexGrow = 1
        }
        
        let mainStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .end, children: [searchImg, rightStack])
        
        let mainInset = ASInsetLayoutSpec(insets: .init(top: 7, left: 7, bottom: 7, right: 7), child: mainStack)
        
        return mainInset
    }
    
    private func setCell() {
        searchImage.contentMode = .scaleAspectFill
        searchImage.style.width = .init(unit: .points, value: isMain ? 126 : 32)
        searchImage.style.height = .init(unit: .points, value: isMain ? 78 : 48)
        searchImage.cornerRadius = isMain ? 15 : 5
        
        let textTitle = NSMutableAttributedString(string: search.title, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        searchTitle.attributedText = textTitle
        
        
        let text = NSMutableAttributedString(string: search.description ?? "", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        searchDescription.attributedText = text
        searchDescription.maximumNumberOfLines = 4
        
        bottomSeparator.backgroundColor = .lightGray
        bottomSeparator.style.height = .init(unit: .points, value: 1)
        bottomSeparator.style.width = .init(unit: .fraction, value: 1)
    }
    
    private func downloadImage(urlString: String) {
        let url = URL(string: urlString)
        
        SDWebImageDownloader.shared.downloadImage(with: url) { image, data, error, isOK in
            
            self.searchImage.image = image
        }
    }
    
    
}
