//
//  StoreCardInformation.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 6/17/19.
//  Copyright © 2019 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit

class StoreCardInformation: NSObject {
    var cost: String?
    var time: NSNumber?
    var uid = SaudiUser.self
    var date: Date?
    var photos: [UIImage]?
    
    init(_ dic: [String:AnyObject]){
        
    }
    
}
