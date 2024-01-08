//
//  SearchViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    var didSendEventClosure: ((TabBarPage) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }

}
