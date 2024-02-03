//
//  LatestTrailersCell.swift
//  Movies
//
//  Created by Olga Sabadina on 11.01.2024.
//

import UIKit

class LatestTrailersCell: BaseHomeCell {
    
    static var identCell = "latestTrailersCell"
    
    override func setPersentLabel() {
        persentLabel.font = UIFont(name: FontConstants.openSansSemiBold, size: 14)
        addSubview(persentLabel)
    }
    
    override func setMoviesNameLabel() {
        moviesNameLabel.textColor = ColorConstans.latestTrailers
        moviesNameLabel.font = UIFont(name: FontConstants.openSansRegular, size: 14)
        addSubview(moviesNameLabel)
    }
    
    override func updateCell() {
        guard let model else {return}
        let urlPoster = URL(string: model.imageUrl)
        imageView.sd_setImage(with: urlPoster)
        persentLabel.text = model.title
        moviesNameLabel.text = model.title
    }
}
