//
//  DataBaseManager.swift
//  UpcomingEvents
//
//  Created by Olga Sabadina on 27.11.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import Firebase
import FirebaseDatabase
import UIKit

final class DatabaseService {
    
    static let shared = DatabaseService()
    var userToSendEvent: UserProfile?
    private init() {}
    
    enum FirebaseRefferencies {
        case profile
        
        var ref: CollectionReference {
            switch self {
            case .profile:
                return Firestore.firestore().collection(TitleConstants.profileCollection)
            }
        }
    }
    
    ///Fetch users profile document from server FireStore
    func fetchProfile(uid: String, completion: @escaping (Result<UserProfile?,Error>)->Void) {
       
        Firestore.firestore().collection(TitleConstants.profileCollection).document(uid).getDocument {document, error in
            
            if let document = document, document.exists {
                do {
                    let userProfile = try document.data(as: UserProfile.self)
                    completion(.success(userProfile))
                } catch {
                    completion(.failure(AuthorizeError.errorParceProfile))
                }
            } else {
                completion(.failure(AuthorizeError.docNotExists))
            }
        }
    }
    
    func deleteProfile(uid: String, errorHandler: ((Error?)->Void)? ) {
        FirebaseRefferencies.profile.ref.document(uid).delete { error in
            errorHandler?(error)
        }
    }
    
    func deleteProfileAsync() async {
        let uid = UserDefaults.standard.string(forKey: TitleConstants.uid) ?? ""
        let path = FirebaseRefferencies.profile.ref.document(uid).path
        try? await FirebaseRefferencies.profile.ref.document(uid).delete()
    }
    
    func sendProfileToServer(uid: String, profile: UserProfile, errorHandler: ((Error?)->Void)?) {
        do {
            try FirebaseRefferencies.profile.ref.document(uid).setData(from: profile, merge: true)
        } catch {
            errorHandler?(AuthorizeError.sendDataFailed)
        }
    }
    
    func checkEmailIsExist(email: String) async throws -> Bool {
        let qSnapShot = try await FirebaseRefferencies.profile.ref.whereField("login", isEqualTo: email).getDocuments().documents
        
        for value in qSnapShot {
            guard let user = UserProfile(qSnapShot: value) else { return false }
            userToSendEvent = user
            return true
        }
        return false
    }
}
