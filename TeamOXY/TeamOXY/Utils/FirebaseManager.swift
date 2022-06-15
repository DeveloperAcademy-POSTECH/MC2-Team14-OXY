//
//  FirebaseManager.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    var currentUser: User?
    
    override init() {
        auth = Auth.auth()
        firestore = Firestore.firestore()
        super.init()
    }
}
