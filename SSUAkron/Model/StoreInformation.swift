//
//  StoreInformation.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import Foundation

class StoreInformationModel: NSObject {
    var title: String?
    var whereToReceive: String!
    var cost:String!
    var descriptionString: String!
    var catagory: String!
    var photoPath: String?
    var whatsAppNumber: String?
    init(_ dic: [String: AnyObject]) {
        //TODO: Add the rest of the data that populates the card
        title =             dic["title"] as? String ?? ""
        whereToReceive =    dic["location"] as? String ?? ""
        cost =              dic["price"] as? String ?? ""
        descriptionString = dic["description"] as? String ?? ""
        catagory =          dic["catagory"] as? String ?? ""
        whatsAppNumber =    dic["whatsappnumber"] as? String ?? nil
        guard let imageDict = dic["picture"] as? [String:String] else {return}
        photoPath = imageDict["image1"] as! String
    }
}
