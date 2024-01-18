//
//  HomeViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var didSendEventClosure: ((TabBarPage) -> Void)?
    private var cancellable = Set<AnyCancellable>()
    var collectionView: UICollectionView?
    let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        setConstraints()
        gradienLayer()
        sincToProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: - private Functions:
    
    private func sincToProperties() {
        homeViewModel.$seeAllSectionType
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { type in
                self.reloadCollection()
        }
        .store(in: &cancellable)
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    private func setView() {
        view.backgroundColor = .white
    }
    
    private func gradienLayer() {
        let backView = UIView()
        backView.frame = view.bounds
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.2, 0.97]
        gradientLayer.frame = .init(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height/2)
      
        let backgroundImage = UIImageView()
        backgroundImage.frame = .init(x: 0, y: 0, width: backView.bounds.width, height: backView.bounds.height/2)
        backgroundImage.image = ImageConstants.homeBackground
        backgroundImage.alpha = 0.6
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.addSublayer(gradientLayer)
        backgroundImage.clipsToBounds = true
        backView.addSubview(backgroundImage)
        
        collectionView?.backgroundView = backView
    }
    
    //MARK: - constraints:
    
    private func setConstraints() {
        guard let collView = collectionView else {return}
        NSLayoutConstraint.activate([
            collView.topAnchor.constraint(equalTo: view.topAnchor),
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

