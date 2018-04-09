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
    var name : String?
    var job : String = "طالب"
    var uid : String?
    var email: String?
    var major: String?
    var university: String?
    var phoneNumber: String?
    var image: UIImage = UIImage(named: "Unknown_Person")!
}
