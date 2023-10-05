//
//  AuthService.swift
//  Twitgram
//
//  Created by Ernazar on 4/10/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine


class AuthService {
    static let shared = AuthService()
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
