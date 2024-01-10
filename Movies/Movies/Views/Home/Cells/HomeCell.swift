//
//  HomeCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit


class HomeCell: UICollectionViewCell {
    
    static var identCell = "homeCell"
    let bacgroundView = UIView()
    var imageView = UIImageView()
    var persentLabel = UILabel()
    var moviesNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setPersentLabel()
        setMoviesNameLabel()
        setBackgroundView()
        setImageView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        persentLabel.text = ""
        moviesNameLabel.text = ""
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bacgroundView.setShadowWithCornerRadius(cornerRadius: 20, shadowColor: .black, shadowOffset: .zero, shadowOpacity: 0.5, shadowRadius: 2)
    }
    
    private func setImageView() {
        imageView.image = ImageConstants.home
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bacgroundView.addSubview(imageView)
    }
    
    private func setBackgroundView() {
        bacgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bacgroundView)
        bacgroundView.backgroundColor = .white
    }
    
    private func setPersentLabel() {
        persentLabel.textColor = ColorConstans.moviesName
        persentLabel.font = UIFont(name: FontsConstants.openSansRegular, size: 14)
        persentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(persentLabel)
    }
    
    private func setMoviesNameLabel() {
        moviesNameLabel.textColor = ColorConstans.moviesName
        moviesNameLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        moviesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moviesNameLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            bacgroundView.topAnchor.constraint(equalTo: topAnchor),
            bacgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bacgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            persentLabel.topAnchor.constraint(equalTo: bacgroundView.bottomAnchor, constant: 5),
            persentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            persentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moviesNameLabel.topAnchor.constraint(equalTo: persentLabel.bottomAnchor, constant: 5),
            moviesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: bacgroundView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: bacgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: bacgroundView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bacgroundView.bottomAnchor)
        ])
    }
    
    
}
