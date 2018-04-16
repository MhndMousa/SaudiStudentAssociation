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
    
    var coordinations: CLLocationCoordinate2D?
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        sender.tap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func setupView()  {
        signUpButton.layer.cornerRadius = radius
        signupContainer.layer.cornerRadius = radius
        dateContainer.layer.cornerRadius = radius
        
        mapContainer.layer.cornerRadius = radius
        mapView.layer.cornerRadius = radius
        mapContainer.addSubview(mapButton)
        mapButton.leftAnchor.constraint(equalTo: mapContainer.leftAnchor, constant: 0).isActive = true
        mapButton.bottomAnchor.constraint(equalTo: mapContainer.bottomAnchor, constant: 0).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 100)
        mapButton.heightAnchor.constraint(equalToConstant: 40)
       
        contContainer.layer.cornerRadius = radius
        
        descriptionContainer.layer.cornerRadius = radius
        descriptionView.layer.cornerRadius = radius
        descriptionView.isEditable = false
        descriptionView.isSelectable = false
        descriptionView.showsVerticalScrollIndicator = false
        descriptionView.font = UIFont(name: "NotoKufiArabic", size: 12)
        
        populateCard()
        
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(viewViewed), userInfo: nil, repeats: false)
    }
    
    @objc func viewViewed() {
        bigAssView.setNeedsLayout()
        bigAssView.setNeedsDisplay()
    }

}   // end Class





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
