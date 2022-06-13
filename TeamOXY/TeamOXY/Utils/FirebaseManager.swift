//
//  FirebaseManager.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        auth = Auth.auth()
        firestore = Firestore.firestore()
        super.init()
    }
}
