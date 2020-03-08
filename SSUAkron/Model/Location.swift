//
//  Location.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import Foundation
import CoreLocation

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
