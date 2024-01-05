//
//  CreateViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit

class CreateViewController: UIViewController {
    
    var didSendEventClosure: ((TabBarPage) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

}
