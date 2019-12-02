//
//  UserInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/6/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit

class SaudiUser : NSObject{
    var name : String?  = nil
    var job : String! = "طالب"
    var uid : String? = nil
    var email: String?  = nil
    var major: String? = nil
    var university: String? = nil
    var phoneNumber: String? = nil
    var image: UIImage! = UIImage(named: "Unknown_Person")!
    var imageLink: String!  = ""
    
    override init() {
        self.name  = nil
        self.job = "طالب"
        self.uid = nil
        self.email  = nil
        self.major = nil
        self.university = nil
        self.phoneNumber = nil
        self.image = UIImage(named: "Unknown_Person")!
        self.imageLink  = ""
    }
    
    
    init(_ child: [String:Any]) {
        self.name = child["name"] as? String ?? "اسم"
        self.uid = child["uid"] as? String ?? ""
        self.phoneNumber = child["whatsappnumber"] as? String ?? nil
        self.job = child["job"] as? String ?? ""
    }
}
