//
//  HomeVC+CollectionView.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit

extension HomeViewController {
    
    func setCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let collectionView = collectionView else {return}
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identCell)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identCell )
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identCell)
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
           
            let sectionType: HomeSectionType = HomeSectionType(rawValue: sectionIndex) ?? .categories
            
            switch sectionType {
            case .categories:
                return self.createCategoriesSection()
            case .popular:
                return self.createImageSection()
            case .freeWatch:
                return self.createImageSection()
            case .latestTrailers:
                return self.createImageSection()
            }
        }
        return layout
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        
        let item = CompositionalLayout.createItem(width: .estimated(80), height: .absolute(30), spacing: 0)
        
        let group = CompositionalLayout.createGroupeCount(aligment: .horizontal, width: .estimated(80), height: .absolute(30), item: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
    
        return section
    }
    
    private func createImageSection() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        
        let group = CompositionalLayout.createGroupeItems(aligment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight((1/3)), items: [item])
        
        group.contentInsets = .init(top: 8, leading: 20, bottom: 8, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 15
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}
    
//  MARK: - CollectionViewDelegate,DataSours:

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        homeViewModel.nuberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.numberItemsInSections(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = HomeSectionType(rawValue: indexPath.section)
        
        switch sectionType {
            
        case .categories:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identCell, for: indexPath) as? CategoriesCell else { return UICollectionViewCell()}
            return cell
            
        case .freeWatch:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            
            return cell
            
        default:
            //return UICollectionViewCell()
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       // if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
        let sectionType: HomeSectionType = HomeSectionType(rawValue: indexPath.section) ?? .categories
        
        switch sectionType {
        case .categories:
            break
        case .popular:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            return header
        case .freeWatch:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            return header
        case .latestTrailers:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            return header
        }
        return UICollectionReusableView()
    }
    
    
}
