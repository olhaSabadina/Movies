//
//  ProfileViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    var didSendEventClosure: ((EventPrifile) -> Void)?
    
    private let deleteProfileButton = UIButton(type: .system)
    private let logOutProfileButton = UIButton(type: .system)
    private let editProfileButton = UIButton(type: .system)
    private var stackButtons = UIStackView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setStackButtons()
        addTargetButton()
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
    
    private func setStackButtons() {
        let buttons = [editProfileButton, logOutProfileButton, deleteProfileButton]
        let titleArr = ["Edit profile", "Log Out", "Delete profile"]
        buttons.enumerated().forEach { index, button in
            button.setTitle(titleArr[index], for: .normal)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.setBorderLayer(backgroundColor: .link, borderColor: .gray, borderWidth: 2, cornerRadius: 20, tintColor: .white)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        }
        
        let actionlogOut = UIAction { action in
            self.didSendEventClosure?(.logOut)
        }
        let actionDeleteProfile = UIAction { action in
            self.didSendEventClosure?(.deleteProfile)
        }
        let actionEditProfile = UIAction { action in
            self.didSendEventClosure?(.editProfile)
        }
        logOutProfileButton.addAction(actionlogOut, for: .touchUpInside)
        deleteProfileButton.addAction(actionDeleteProfile, for: .touchUpInside)
        editProfileButton.addAction(actionEditProfile, for: .touchUpInside)
        
        editProfileButton.isEnabled = true
        stackButtons = UIStackView(arrangedSubviews: buttons)
        stackButtons.axis = .vertical
        stackButtons.spacing = 18
        stackButtons.distribution = .fillEqually
        stackButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackButtons)
    }
    
    private func addTargetButton() {
//        logOutProfileButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
//        deleteProfileButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
//        editProfileButton.addTarget(self, action: #selector(editUserProfile), for: .touchUpInside)
    }
    
    //MARK: - constraints:
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            stackButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),            stackButtons.heightAnchor.constraint(equalToConstant: 200),
        
        ])
    }
}

extension ProfileViewController {
    enum EventPrifile {
        case logOut
        case deleteProfile
        case editProfile
    }
}

  
