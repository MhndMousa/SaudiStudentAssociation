//
//  MapPin.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/3/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import MapKit

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
