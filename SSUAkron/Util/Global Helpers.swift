//
//  Global.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/20/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

var ref  =  Database.database().reference()
let storageRef = Storage.storage().reference()

func refreshCurrentUserInfo() {
    currentUser = getUserInfo()
}

func getUserInfo() -> SaudiUser {
    let currentUser = Auth.auth().currentUser
    let user = SaudiUser()
    if let uid = currentUser?.uid{
        let ref = Database.database().reference().child("users").child(uid)
            ref.observe(.value) { (snapshot) in
                let value = snapshot.value as! [String: Any]
                user.name = value["name"] as? String
                user.email = value["email"] as? String
                user.uid = currentUser?.uid
                user.major = value["major"] as? String
                user.phoneNumber = value["phone_number"] as? String
                user.university = value["university"] as? String
                user.job = value["job"] as? String 
        }
    }
    return user
}
