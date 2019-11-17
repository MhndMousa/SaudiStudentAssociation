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

    // MARK: - Properties
    

    @IBOutlet var regestraionStatusLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var descriptionView: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var signUpButton: UIButton!
    var coordinations: CLLocationCoordinate2D?
    weak var eventInfo : EventCellInfo? {
        didSet{
            
            guard let eventInfo = self.eventInfo else { fatalError()}
            self.title = eventInfo.title
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.dateLabel.alpha = 0
                self.descriptionView.alpha = 0
                self.costLabel.alpha = 0
                self.timeLabel.alpha = 0
                self.mapView.alpha = 0
                self.regestraionStatusLabel.alpha = 0
             }, completion: { (_) in
                
                self.dateLabel.text = eventInfo.date
                self.descriptionView.text = eventInfo.eventDescription
                self.costLabel.text = eventInfo.cost
                self.timeLabel.text = eventInfo.time?.stringValue 
                
                self.regestraionStatusLabel.text = eventInfo.registered ? "مسجل" : "غير مسجل"
                
                
//                let center = CLLocationCoordinate2DMake(39.659996, -86.197870)
//                let mappin = MapPin(coordinate: center, title: "Home", subtitle: "My homie")
                self.mapView?.centerCoordinate = eventInfo.location.center
                self.mapView.addAnnotation(eventInfo.location.pin)
                self.mapView?.camera.altitude = 2000
                
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.dateLabel.alpha = 1
                    self.descriptionView.alpha = 1
                    self.costLabel.alpha = 1
                    self.timeLabel.alpha = 1
                    self.mapView.alpha = 1
                    self.regestraionStatusLabel.alpha = 1

                  
                }, completion:nil)
             })
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        dateLabel = UILabel()
        descriptionView = UILabel()
        costLabel = UILabel()
        timeLabel = UILabel()
        mapView = MKMapView()
        regestraionStatusLabel = UILabel()
    }
    convenience init(event : EventCellInfo) {
        self.init()
        eventInfo = event
    }
    
    deinit {
        dateLabel = nil
        descriptionView = nil
        costLabel = nil
        timeLabel = nil
        mapView = nil
        regestraionStatusLabel = nil
        eventInfo = nil
        coordinations = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.titleLabel?.text = "navigate"
        button.backgroundColor = .blue
        return button
    }()
    
 
    // MARK: - View Controller Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.setCenter(eventInfo!.location.center, animated: true)
    }
    
    
    // MARK: - Helpers
    
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
    
    // MARK: - Handlers

     @IBAction func signUpClicked(_ sender: UIButton) {
         sender.tap()
     }

    
    
}



