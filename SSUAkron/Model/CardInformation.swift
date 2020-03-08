//
//  CardInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/24/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class EventCellInfo: NSObject {
    var title: String!
    var catagory: String?
    var icon : UIImage?
    var time: String?
    var date: String?
    var dates: Date
    var times: Date
    var cost: NSNumber?
    var registered: Bool!
    var eventDescription: String?
    var location: Location!
    var id : String!
    
    init(_ dic: [String: AnyObject]) {
        self.title =      dic["title"] as? String ?? ""
        self.catagory =   dic["catagory"] as? String ?? ""
        self.title =      dic["title"] as? String ?? " "
        self.catagory =   dic["catagory"] as? String ?? " "
        self.time =       dic["time"] as? String ?? " "
        self.date =       dic["date"] as? String ?? " "
        self.cost =       dic["cost"] as? NSNumber ?? 0
        self.id =         dic["id"] as? String ?? ""
        self.registered = dic["registered"] != nil ? dic["registered"]?.contains(currentUser.uid!) : false // Check if anyone registered -> if not return false, check the registers and return if they exist
        self.eventDescription = dic["eventDescription"] as? String ?? " "
        self.icon = eventIcons(rawValue: dic["icon"] as! String)!.image
        
        
        // Used to calculate time of the event
        let date   = dic["dates"] as? Double ?? 0.0
        let time   = dic["time"] as? Double ?? 0.0
        self.dates = Date(timeIntervalSince1970: date)
        self.times = Date(timeIntervalSince1970: time)
    
        // Checks if dictionary value is nil first, if not checks if the current user is registered on or not and return that value
        let location_name        = dic["location_name"] as? String ?? ""
        let location_description = dic["location_description"] as? String ?? ""
        
        // Exctract coordinates (long, lat)
        guard let location       = dic["coordinates"] as? [String: Double] else {
            self.location = Location(CLLocationCoordinate2DMake(0, 0))
            return
        }
        self.location = Location(center: CLLocationCoordinate2DMake(location["lat"]!, location["long"]!), title: location_name, subtitle: location_description)
    }
}
