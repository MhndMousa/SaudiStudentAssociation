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
    let mapButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.titleLabel?.text = "navigate"
        button.backgroundColor = .blue
        return button
    }()
    weak var eventInfo : EventCellInfo? {
        didSet{
            updatePostInformation()
        }
    }
    
    // MARK: Initializers
    
    init(event : EventCellInfo) {
        eventInfo = event
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.setCenter(eventInfo!.location.center, animated: true)
        signUpButton.layer.cornerRadius = 5
        mapView.clipsToBounds = true
    }
    
    
    // MARK: - Helpers
    
    func updatePostInformation() {
                    
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
            self.costLabel.text = eventInfo.cost == 0 ? "مجاني" : eventInfo.cost?.stringValue.appending(" دولار")
            self.toggleRegistraionStatus()
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
    
    // MARK: - Handlers

    func toggleRegistraionStatus(){

        self.regestraionStatusLabel.text = self.eventInfo!.registered ? "مسجل" : "غير مسجل"
        self.regestraionStatusLabel.textColor = self.eventInfo!.registered ?  .systemGreen : .systemRed

    }
    
     @IBAction func signUpClicked(_ sender: UIButton) {
         sender.tap()

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


    @IBAction func googleMapsTapped(_ sender: Any) {
        guard let eventInfo = eventInfo else {return}
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
          UIApplication.shared.openURL(URL(string:
            "comgooglemaps://?center=\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)&zoom=14&views=traffic")!)
        } else {
            UIApplication.shared.openURL(NSURL(string:"https://maps.google.com/?q=@\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)")! as URL)
          print("Can't use comgooglemaps://");
        }
        
    }
    @IBAction func appleMapsTapped(_ sender: Any) {
        guard let eventInfo = eventInfo else {return}
        UIApplication.shared.openURL(URL(string: "http://maps.apple.com/?q=\(eventInfo.location.center.latitude),\(eventInfo.location.center.longitude)")!)
    }
    
}


