//
//  EventIcons.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import UIKit

enum eventIcons :String,CaseIterable {
    case food = "food_black"
    case fastfood = "fastfood_black"
    case woman = "woman_black"
    case sports = "sports_black"
    case message = "message_black"
    static let values = [food,woman,fastfood, sports, message]
    
    var image :UIImage{
        switch self {
        case .food :return UIImage(fromAssets: .food)
        case .woman :return UIImage(fromAssets: .woman)
        case .sports :return UIImage(fromAssets: .sports)
        case .message :return UIImage(fromAssets: .message)
        case .fastfood :return UIImage(fromAssets: .fastfood)
        }
    }
}
