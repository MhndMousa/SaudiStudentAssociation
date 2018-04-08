//
//  EventInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/27/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit


class EventInformation: UIViewController {

    var radius : CGFloat = 12
    @IBOutlet var bigAssView: UIView!
    
    @IBOutlet weak var signupContainer: UIView!
    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var contContainer: UIView!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var descriptionContainer: UIView!
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUpClicked(_ sender: UIButton) {
    
        sender.tap()
    }
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TODO: Connect this to a button in the card
    func openMapForPlace(c : CLLocationCoordinate2D) {
        
        let latitude: CLLocationDegrees = c.latitude
        let longitude: CLLocationDegrees = c.longitude
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
    }
    
    func loadData()  {
        
        signUpButton.layer.cornerRadius = radius
        
        signupContainer.layer.cornerRadius = radius
        dateContainer.layer.cornerRadius = radius
        mapContainer.layer.cornerRadius = radius
        contContainer.layer.cornerRadius = radius
        descriptionContainer.layer.cornerRadius = radius
        mapView.layer.cornerRadius = radius
        descriptionView.layer.cornerRadius = radius
        descriptionView.font = UIFont(name: "NotoKufiArabic", size: 12)
        
        let center = CLLocationCoordinate2DMake(39.659996, -86.197870)
        mapView?.centerCoordinate = center
        
        
        
        mapView.addAnnotation(MapPin(coordinate: center, title: "Home", subtitle: "My homie"))
        
        mapView?.camera.altitude = 2000
        
        bigAssView.setNeedsLayout()
        bigAssView.setNeedsDisplay()
    }
}

extension UIButton{
    func pulse()  {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.96
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount  = 1
        pulse.initialVelocity = 0.6
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
    
    
    func tap()  {
        UIButton.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { _ in
            UIButton.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}
