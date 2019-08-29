//
//  CardInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/24/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

class CardInformaion: NSObject {
<<<<<<< HEAD
    enum eventIcons {
        case food, celebration, gathering
        var image: UIImage {
            switch self {
            case .food: return #imageLiteral(resourceName: "ic_account_circle")
            case .celebration: return #imageLiteral(resourceName: "ic_check")
            case .gathering: return #imageLiteral(resourceName: "ic_attach_money")
                
            }
        }
        
        
    }
    
    
    
    var title: String?
=======
    var title: String 
    var catagory: String?
>>>>>>> master
    var itemTitle: String?
    var itemSubtitle: String?
    var image: UIImage = #imageLiteral(resourceName: "ssa")
    var icon : UIImage?
    var backgroundColor: UIColor?
    var textColor: UIColor?
    var userID: String?
    var time: NSNumber = 0
    var cardId: String?
    
    init(_ dic: [String: AnyObject]) {
        //TODO: Add the rest of the data that populates the card
        title = dic["title"] as? String ?? ""
        itemTitle = dic["itemTitle"] as? String ?? ""
        itemSubtitle = dic["itemSubtitle"] as? String ?? ""
        
    }
    
    init(_ dic: [String: AnyObject], _ colors: [String:UIColor]) {
        
        //TODO: Add the rest of the data that populates the card
        title = dic["title"] as? String ?? ""
        itemTitle = dic["itemTitle"] as? String ?? ""
        itemSubtitle = dic["itemSubtitle"] as? String ?? ""
        
        let b = dic["backgroundColor"] as? String ?? "pink"
        let t = dic["textColor"] as? String ?? "white"
        textColor = colors[t]
        backgroundColor = colors[b]
    }

}

