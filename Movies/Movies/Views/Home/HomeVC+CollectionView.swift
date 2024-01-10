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
      //  collectionView.backgroundColor = .clear
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
                return self.createlatestTrailersSection()
            case .trending:
                return self.createImageSection()
            }
        }
        return layout
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.25), height: .absolute(30), spacing: 10)
        
        let group = CompositionalLayout.createGroupeCount(aligment: .horizontal, width: .fractionalWidth(1), height: .absolute(30), item: item, count: 4)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
        return section
    }
    
    private func createImageSection() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        
        let group = CompositionalLayout.createGroupeItems(aligment: .vertical, width: .fractionalWidth(0.38), height: .fractionalHeight((1/3)), items: [item])
                
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 10, leading: 16, bottom: 20, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createlatestTrailersSection() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        
        let group = CompositionalLayout.createGroupeItems(aligment: .vertical, width: .fractionalWidth(0.75), height: .fractionalHeight((0.25)), items: [item])
                
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 10, leading: 16, bottom: 20, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
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
            cell.categoriesButton.setTitle(homeViewModel.categoriesTitle[indexPath.item], for: .normal)
            return cell
            
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            cell.persentLabel.text = homeViewModel.viewsPercent[indexPath.item]
            cell.moviesNameLabel.text = homeViewModel.moviesTitle[indexPath.item]
            return cell
            
        case .freeWatch:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            cell.persentLabel.text = homeViewModel.viewsPercent[indexPath.item]
            cell.moviesNameLabel.text = homeViewModel.moviesTitle[indexPath.item]
            return cell
            
        case .latestTrailers:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            cell.persentLabel.text = homeViewModel.viewsPercent[indexPath.item]
            cell.moviesNameLabel.text = homeViewModel.moviesTitle[indexPath.item]
            return cell
            
        case .trending:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            cell.persentLabel.text = homeViewModel.viewsPercent[indexPath.item]
            cell.moviesNameLabel.text = homeViewModel.moviesTitle[indexPath.item]
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionType: HomeSectionType = HomeSectionType(rawValue: indexPath.section) ?? .categories
        
        switch sectionType {
        case .categories:
            break
        case .popular:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            header.sectionType = sectionType
            header.actionSeeAll = {
                print(header.headerLabel.text ?? "nil")
            }
            header.segmentAction = { index in
                print(index, "segment index")
            }
            return header
        case .freeWatch:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            header.sectionType = sectionType
            return header
        case .latestTrailers:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            header.sectionType = sectionType
            return header
        case .trending:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identCell, for: indexPath) as? HeaderCell else {return UICollectionReusableView()}
            header.sectionType = sectionType
            return header
        }
        return UICollectionReusableView()
    }
    
    
}
