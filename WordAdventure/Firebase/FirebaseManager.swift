//
//  FirebaseManager.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 29.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager: NSObject {
    let firestore: Firestore
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        super.init()
    }
}
