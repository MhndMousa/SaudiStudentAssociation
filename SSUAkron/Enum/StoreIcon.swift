//
//  StoreIcon.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit
enum storeIcons:String,CaseIterable{
    case auto = "commute_black"
    case electronics =  "computer_black"
    case books = "book_black"
    case appliances = "house_black"
    static let values = [auto,electronics,books,appliances ]
    
    var image : UIImage{
        switch self {
        case .auto :return UIImage(fromAssets: .auto)
        case .electronics :return UIImage(fromAssets: .electronics)
        case .appliances :return UIImage(fromAssets: .appliances)
        case .books :return UIImage(fromAssets: .books)
        }
    }
    
}
