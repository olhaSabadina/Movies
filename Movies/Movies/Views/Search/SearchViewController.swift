//
//  SearchViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import AsyncDisplayKit

class SearchViewController: ASDKViewController<ASDisplayNode> {

    var isSearch: Bool = false {
        didSet {
            tableSearch.reload(isSearch: isSearch)
        }
    }
    
    private var tableSearch: SearchTable
    
    private let rootNode: ASDisplayNode = {
        let root = ASDisplayNode()
        root.automaticallyManagesSubnodes = true
        return root
    }()
    
    override init() {
        tableSearch = SearchTable()
        super.init(node: rootNode)
        node.layoutSpecBlock = {_,_ in
            return ASInsetLayoutSpec(insets: .init(), child: self.tableSearch)
        }
    }
    
    required init?(coder: NSCoder) {
        tableSearch = SearchTable()
        super.init(node: rootNode)
    }
    
    override func loadView() {
        super.loadView()
        setSearchController()
        navigationItem.backButtonTitle = ""
//        tableSearch.completionAction = { search in
//            let vc = DetailsViewController()
//            vc.title = search.title
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    private func setSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        title = "Search VC"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .systemBackground
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //срабатывает каждый раз при вводе текста в сеарче
        filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.count >= 1 {
            isSearch = true
        } else{
            isSearch = false
        }
    }
}
