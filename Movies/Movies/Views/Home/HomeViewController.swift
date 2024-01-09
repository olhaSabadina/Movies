//
//  HomeViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var didSendEventClosure: ((TabBarPage) -> Void)?
    
    var collectionView: UICollectionView?
    let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        setConstraints()
    }
    
    //MARK: - private Functions:
    
    private func setView() {
        view.backgroundColor = .white
        let background = UIImageView()
        background.frame = view.bounds
        background.image = ImageConstants.homeBackground
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
    }
    
    //MARK: - constraints:
    
    private func setConstraints() {
        guard let collView = collectionView else {return}
        NSLayoutConstraint.activate([
            collView.topAnchor.constraint(equalTo: view.topAnchor),
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

