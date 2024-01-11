//
//  BaseHomeCell.swift
//  Movies
//
//  Created by Olga Sabadina on 11.01.2024.
//

import UIKit

class BaseHomeCell: UICollectionViewCell {
    
    let bacgroundView = UIView()
    var imageView = UIImageView()
    var circleView = UIView()
    var persentLabel = UILabel()
    var moviesNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setPersentLabel()
        setMoviesNameLabel()
        setBackgroundView()
        setImageView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        persentLabel.text = ""
//        moviesNameLabel.text = ""
//        imageView.image = nil
    }
    
    func setPersentLabel() {}
    func setMoviesNameLabel() {}
    func setConstraints() {}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bacgroundView.setShadowWithCornerRadius(cornerRadius: 20, shadowColor: .black, shadowOffset: .zero, shadowOpacity: 0.5, shadowRadius: 2)
        circleView.circleStrokeView(total: 50, current: 30)
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
}
