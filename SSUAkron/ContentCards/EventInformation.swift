//
//  EventInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/27/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit
import Firebase


class EventInformation: UIViewController{

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var coordinations: CLLocationCoordinate2D?
    var radius : CGFloat = 12
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        sender.tap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
    }
    
    
    let mapButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.titleLabel?.text = "navigate"
        button.backgroundColor = .blue
        return button
    }()
    
    // TODO: Connect this to a button in the card
    @objc func openMapForPlace() {
        let c = coordinations
        let latitude: CLLocationDegrees = c!.latitude
        let longitude: CLLocationDegrees = c!.longitude
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
    }

    func populateCard() {
        
        // Data base refrence to populate the card with appropraite choice
        
        let center = CLLocationCoordinate2DMake(39.659996, -86.197870)
        mapView?.centerCoordinate = center
        let mappin = MapPin(coordinate: center, title: "Home", subtitle: "My homie")
        mapView.addAnnotation(mappin)
        mapView?.camera.altitude = 2000
    }
    
    
}   // end Class




