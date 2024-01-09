//
//  HomeCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit


class HomeCell: UICollectionViewCell {
    
    static var identCell = "homeCell"
    
    var imageView = UIImageView()
    var persentLabel = UILabel()
    var moviesNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setImageView()
        setPersentLabel()
        setMoviesNameLabel()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setImageView() {
        imageView.backgroundColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    private func setPersentLabel() {
        persentLabel.text = "90%"
        persentLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 18)
        persentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(persentLabel)
    }
    
    private func setMoviesNameLabel() {
        moviesNameLabel.text = "Mare of Easttown"
        moviesNameLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 18)
        moviesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moviesNameLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            persentLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            persentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            persentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moviesNameLabel.topAnchor.constraint(equalTo: persentLabel.bottomAnchor, constant: 5),
            moviesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
