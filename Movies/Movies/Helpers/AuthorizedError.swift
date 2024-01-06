//
//  AuthorizedError.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import Foundation

enum AuthorizeError: String, Error {
    case uid = "Your UID is empty, Can't receive..."
    case errorParceProfile = "Can't parce data to Profile struct"
    case docNotExists = "Sorry. \nThis document not exists"
    case sendDataFailed = "Sorry, can't send data profile to server FireStore"
    case noFoundID = "NO client ID found in FireBase configuration"
    case notRootVC = "There is no root view controller "
    case errorToken = "ID token missing"
    case cancelAppleAuth = "Canceled Apple sign in authentication"
    case userNotFound = "Sorry user not found" // used
    case badUrl = "Bad url"
}
