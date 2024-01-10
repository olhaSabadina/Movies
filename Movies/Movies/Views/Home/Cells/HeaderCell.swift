//
//  HeaderCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//


import UIKit

class HeaderCell: UICollectionReusableView {
    
    static let identCell = "headerCell"
    
    var actionSeeAll: (()->Void)?
    var segmentAction: ((Int)->Void)?
    var headerLabel = UILabel()
    let seeAllButton = UIButton(type: .system)
    var sectionType: HomeSectionType = .categories {
        didSet {
            setHeaderData()
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setHeaderLabelAndSegment()
        setSeeAllButton()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerLabel.text = ""
        
    }
    
    private func setHeaderLabelAndSegment() {
        headerLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        
    }
    
    private func setSeeAllButton() {
        seeAllButton.backgroundColor = .clear
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.titleLabel?.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        seeAllButton.tintColor = .systemBlue
        seeAllButton.titleLabel?.textAlignment = .right
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seeAllButton)
        
        let action = UIAction { _ in
            self.actionSeeAll?()
        }
        seeAllButton.addAction(action, for: .touchUpInside)
    }
    
    private func setHeaderData() {
        let moviesSegmentControl = MoviesSegmentControl(self.sectionType.headersSegments, action: { index in
            self.segmentAction?(index)
        })
        moviesSegmentControl.tag = 7
        self.headerLabel.text = self.sectionType.headerTitle
        
        subviews.forEach { view in
            if view.tag == 7 {
                print(view.tag)
                view.removeFromSuperview()
            }
            
        }
        moviesSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moviesSegmentControl)
        NSLayoutConstraint.activate([
            moviesSegmentControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesSegmentControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesSegmentControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            moviesSegmentControl.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
