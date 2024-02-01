//
//  SearchTable.swift
//  Movies
//
//  Created by Olga Sabadina on 23.01.2024.
//

import AsyncDisplayKit

protocol HeaderShowFullTable {
    func didShowFullTable()
}

class SearchTable: ASTableNode {
    
    var typeCell: TypeSearchCell = .short
    var completionAction: ((MovieCellModel) -> Void)?
    var searchs: [MovieCellModel] = []
    var headerDelegate: HeaderShowFullTable?
    
    init(movies: [MovieCellModel] = searchMain, typeCell: TypeSearchCell = .full) {
        self.typeCell = typeCell
        super.init(style: .plain)
        searchs = movies
        self.delegate = self
        self.dataSource = self
        self.view.separatorStyle = .none
        self.style.width = .init(unit: .fraction, value: 1)
        self.style.height = .init(unit: .fraction, value: 1)
        self.style.flexShrink = 1
    }

    func reload(isSearch: Bool) {
        searchs = !isSearch ? searchMain : searchSearch
        self.typeCell = !isSearch ? .full : .short
        reloadData()
    }
}

extension SearchTable: ASTableDelegate, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        if typeCell == .full || typeCell == .medium {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = "Trending"
        var header = UIView()
        switch typeCell {
            
        case .full,.short:
             header = HeaderInTable(title: title, type: typeCell)
            
        case .medium:
             header = HeaderForSections(headerData: .init(title: "Acting", type: .simple)) { type in
                print("see all")
                 self.headerDelegate?.didShowFullTable()
             } actionSegment: { _ in
                 
             }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        searchs.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let search = searchs[indexPath.row]
        return { SearchCell(search: search, type: self.typeCell) }
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        guard let cell = tableNode.nodeForRow(at: indexPath) as? SearchCell else { return }
        completionAction?(cell.model)
    }
    
}
