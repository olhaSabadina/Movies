//
//  SearchTable.swift
//  Movies
//
//  Created by Olga Sabadina on 23.01.2024.
//

import AsyncDisplayKit

class SearchTable: ASTableNode {
    
    var isSearch: Bool = false
    
    init(movies: [MovieCellModel] = searchMain) {
        super.init(style: .plain)
        searchs = movies
        self.delegate = self
        self.dataSource = self
        self.view.separatorStyle = .none
        self.style.width = .init(unit: .fraction, value: 1)
        self.style.height = .init(unit: .fraction, value: 1)
        self.style.flexShrink = 1
    }
    
    var searchs: [MovieCellModel] = []
    
    func reload(isSearch: Bool) {
        searchs = !isSearch ? searchMain : searchSearch
        self.isSearch = isSearch
        reloadData()
    }
    
}

extension SearchTable: ASTableDelegate, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = "Trending"
        let header = HeaderInTable(title: title, isMain: !isSearch)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        searchs.count
    }
    
//    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
//        let search = searchs[indexPath.row]
//        return {SearchCell(search: search, isMain: !self.isSearch) }
//    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        let cell = tableNode.nodeForRow(at: indexPath) as? SearchCell
        print(cell?.search.title ?? "unknow")
    }
    
}
