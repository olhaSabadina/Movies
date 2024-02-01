//
//  HomeItemDetailsViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 11.01.2024.
//

import UIKit
import Combine

class HomeItemDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    //MARK: - setView elements:
    
    private func configureView() {
        view.backgroundColor = .yellow
    }
}
