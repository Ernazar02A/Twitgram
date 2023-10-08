//
//  DatabaseService.swift
//  Twitgram
//
//  Created by Ernazar on 6/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseService {
    
    static let shared = DatabaseService()
    
    let db = Firestore.firestore()
    let userPath: String = "users"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(userPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(retreive id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(userPath).document(id).getDocument()
            .tryMap { try  $0.data(as: TwitterUser.self) }
            .eraseToAnyPublisher()
    }
}
