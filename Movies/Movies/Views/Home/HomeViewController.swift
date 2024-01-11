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
        sincToProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.gradientBackgroundHorizontal(leftColor: .clear.withAlphaComponent(0), rightColor: .red)
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
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

