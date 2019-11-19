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

class Location: NSObject {
    
    var center : CLLocationCoordinate2D! = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var title: String! = "title"
    var subtitle: String! = "subtitle"
    var pin :MapPin!
    
    init(center: CLLocationCoordinate2D, title: String, subtitle: String) {
        super.init()
        self.center = center
        self.title = title
        self.subtitle = subtitle
        self.pin = MapPin(coordinate: center, title: title, subtitle: subtitle)
    }
    init(_ center: CLLocationCoordinate2D) {
        super.init()
        self.center = center
        self.pin = MapPin(coordinate: center, title: "title", subtitle: "subtitle")
    }
    override init() {
        super.init()
        self.pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), title: "title", subtitle: "subtitle")
    }
}

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
        
        
        
        self.title = dic["title"] as? String ?? ""
        self.catagory = dic["catagory"] as? String ?? ""
        self.icon = updateIcon(dic["icon"] as? String ?? "")
        self.title = dic["title"] as? String ?? " "
        self.catagory = dic["catagory"] as? String ?? " "
        self.time = dic["time"] as? String ?? " "
        self.date = dic["date"] as? String ?? " "
        
        let d = dic["dates"] as? Double ?? 0.0
        self.dates = Date(timeIntervalSince1970: d)
        let t = dic["time"] as? Double ?? 0.0
        self.times = Date(timeIntervalSince1970: t)
        
        self.cost = dic["cost"] as? NSNumber ?? 0
        self.eventDescription = dic["eventDescription"] as? String ?? " "
        self.id = dic["id"] as? String ?? ""
        
        // Checks if dictionary value is nil first, if not checks if the current user is registered on or not and return that value
        self.registered = dic["registered"] != nil ? dic["registered"]?.contains(currentUser.uid!) : false
        
        let location_name = dic["location_name"] as? String ?? ""
        let location_description = dic["location_description"] as? String ?? ""
        
        
        // Exctract coordinates (long, lat)
        guard let location = dic["coordinates"] as? [String: Double] else {
            self.location = Location(CLLocationCoordinate2DMake(0, 0))
            return
        }
        self.location = Location(center: CLLocationCoordinate2DMake(location["lat"]!, location["long"]!), title: location_name, subtitle: location_description)
        
        
        
    }
    deinit{
        title = nil
        catagory = nil
        icon = nil
        title = nil
        catagory = nil
        time = nil
        date = nil
        cost = nil
        registered = nil
        eventDescription = nil
        location = nil
        
        
    }

}
class StoreInformationModel: NSObject {
    var title: String?
    var whereToReceive: String!
    var cost:String!
    var descriptionString: String!
    var catagory: String!
    var photoPath: String?
    var whatsAppNumber: String?
    
    override init(){
        title = "test"
        whereToReceive = "test"
        cost = "test"
        descriptionString = "test"
        catagory = "test"
    }
    
    init(_ dic: [String: AnyObject]) {
        //TODO: Add the rest of the data that populates the card
        title = dic["title"] as? String ?? ""
        whereToReceive = dic["location"] as? String ?? ""
        cost =  dic["price"] as? String ?? ""
        descriptionString = dic["description"] as? String ?? ""
        catagory = dic["catagory"] as? String ?? ""
        whatsAppNumber = dic["whatsapp"] as? String ?? nil
                
        guard let imageDict = dic["picture"] as? [String:String] else {return}
        photoPath = imageDict["image1"] as! String
    }
}
