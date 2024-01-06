//
//  AuthorizedManager.swift
//  Movies
//
//  Created by Olga Sabadina on 06.01.2024.
//


import Foundation
import FirebaseCore
import Combine
import FirebaseAuth

enum SessionState {
    case loggedIn
    case loggedOut
    case unknow
}

final class AuthorizedManager: NSObject {
    
    static let shared = AuthorizedManager()
    
    @Published var userProfile: UserProfile?
    @Published var sessionState: SessionState = .unknow
    
    var uid = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var handle: AuthStateDidChangeListenerHandle?
    
    func setupFirebaseAuth() {
        handle = Auth.auth().addStateDidChangeListener {[weak self] auth, user in
            guard let self = self else { return }
            self.sessionState = user == nil ? .loggedOut : .loggedIn
            guard let user = user else { return }
            self.uid = user.uid

            UserDefaults.standard.set(user.uid, forKey: TitleConstants.uid)
        }
    }
    
    func logIn(email: String, pasword: String, errorHandler: ((Error)->Void)?) {
        Auth.auth().signIn(withEmail: email, password: pasword) { result, error in
                if let err = error {
                errorHandler?(err)
            }
        }
    }
    
    func signUp(_ email: String, _ pasword: String, profile: UserProfile?, errorHandler: ((Error?)->Void)?) {
        guard var profile = profile else { return }
       
        Auth.auth().createUser(withEmail: email, password: pasword) { [weak self] result, error in
            if let error = error {
                errorHandler?(error)
            } else {
                guard let user = result?.user else {
                    errorHandler?(AuthorizeError.userNotFound)
                    return}
            
                let uid = user.uid
                self?.uid = uid
                profile.uid = uid

                DatabaseService.shared.sendProfileToServer(uid: uid, profile: profile) { error in
                    errorHandler?(error)
                }
            }
        }
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        self.uid = ""
        self.userProfile = nil
    }
}

