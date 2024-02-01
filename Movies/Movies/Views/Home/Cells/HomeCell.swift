//
//  HomeCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//
import SDWebImage
import UIKit


class HomeCell: BaseHomeCell {
    
    static var identCell = "homeCell"
    var model: MovieCellModel? = nil {
        didSet {
            updateCell()
        }
    }
    
    override func setPersentLabel() {
        persentLabel.textColor = ColorConstans.moviesName
        persentLabel.font = UIFont(name: FontsConstants.openSansRegular, size: 14)
        persentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(persentLabel)
        circleView.backgroundColor = .yellow
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleView)
    }
    
    override func setMoviesNameLabel() {
        moviesNameLabel.textColor = ColorConstans.moviesName
        moviesNameLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        moviesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moviesNameLabel)
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            bacgroundView.topAnchor.constraint(equalTo: topAnchor),
            bacgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bacgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            circleView.topAnchor.constraint(equalTo: bacgroundView.bottomAnchor, constant: 5),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 15),
            
            persentLabel.topAnchor.constraint(equalTo: bacgroundView.bottomAnchor, constant: 5),
            persentLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 3),
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

    private func updateCell() {
        guard let model else {return}
        let urlPoster = URL(string: model.imageUrl)
        imageView.sd_setImage(with: urlPoster)
        DispatchQueue.main.async {
            self.circleView.circleStrokeView(total: 100, current: model.percent ?? 0)
        }
        persentLabel.text = "\(model.percent ?? 0) %"
        moviesNameLabel.text = model.title
    }
}
 
