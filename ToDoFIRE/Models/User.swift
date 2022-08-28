//
//  User.swift
//  ToDoFIRE
//
//  Created by Nikolai Maksimov on 28.08.2022.
//

import Foundation
import Firebase

struct AppUser {
    
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
