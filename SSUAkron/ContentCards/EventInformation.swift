//
//  EventInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/27/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase


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
    @IBAction func appleMapsTapped(_ sender: Any) {
       
        guard let eventInfo = eventInfo else {
            return
        }
        
        UIApplication.shared.openURL(URL(string: "http://maps.apple.com/?q=\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)")!)
       
        
        
    }
    @IBAction func googleMapsTapped(_ sender: Any) {
        
        guard let eventInfo = eventInfo else {
            return
        }
//        print("\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)")
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
          UIApplication.shared.openURL(URL(string:
            "comgooglemaps://?center=\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)&zoom=14&views=traffic")!)
        } else {
            UIApplication.shared.openURL(NSURL(string:
            "https://maps.google.com/?q=@\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)")! as URL)
          print("Can't use comgooglemaps://");
        }
    }
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
                
                let date = eventInfo.dates
                self.dateLabel.text = "\(date.day) \(date.month) \(date.year)"
                self.timeLabel.text = "\(date.hour):\(date.minutes) \(date.timeOfDay)"
                
                self.descriptionView.text = eventInfo.eventDescription
//                self.descriptionView.text = eventInfo.eventDescription!.appending("\n\n\n سوف تقام الفعالية في:  \n \(eventInfo.location.subtitle)")
                self.costLabel.text = eventInfo.cost == 0 ? "مجاني" : eventInfo.cost?.stringValue.appending(" دولار")
                
//                self.id = eventInfo.id
                
//                self.regestraionStatusLabel.text = eventInfo.registered ? "مسجل" : "غير مسجل"
//                self.regestraionStatusLabel.textColor = eventInfo.registered ? .systemRed : .systemGreen
                self.toggleRegistraionStatus()
                
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.setCenter(eventInfo!.location.center, animated: true)
        signUpButton.layer.cornerRadius = 5
        mapView.clipsToBounds = true
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

    func toggleRegistraionStatus(){

        self.regestraionStatusLabel.text = self.eventInfo!.registered ? "مسجل" : "غير مسجل"
        self.regestraionStatusLabel.textColor = self.eventInfo!.registered ?  .systemGreen : .systemRed

    }
    
     @IBAction func signUpClicked(_ sender: UIButton) {
         sender.tap()
        
  
//        self.regestraionStatusLabel.text = self.eventInfo!.registered ? "مسجل" : "غير مسجل"
//        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
//            self.regestraionStatusLabel.text = self.eventInfo!.registered ? "مسجل" : "غير مسجل"
//
//        }, completion: nil)
//        self.regestraionStatusLabel.layoutIfNeeded()

        sender.showSpinner()
        ref.child("Event").child(self.eventInfo!.id).child("Registered").updateChildValues(([currentUser.uid: self.eventInfo!.registered])) { (error, ref) in
            
            if error != nil{
                self.showAlert()
                return
            }
            
            self.eventInfo!.registered = !self.eventInfo!.registered
            let animation = CATransition()
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.4, 0.4, 0.4)
            sender.removeSpinner()
            self.regestraionStatusLabel.layer.add(animation, forKey: nil)
            self.toggleRegistraionStatus()
        }
        
     }

    
    
}



extension Date {
    var year:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
//        dateFormatter.dateStyle = .
        return dateFormatter.string(from: self)
    }
    var day :String{
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h"
        return dateFormatter.string(from: self)
    }
    var minutes: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "m"
        return dateFormatter.string(from: self)
    }
    
    var timeOfDay: String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "a"
       return dateFormatter.string(from: self)
   }
       
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd mmmm yyyy"
        return dateFormatter.string(from: self)
    }
    
}
