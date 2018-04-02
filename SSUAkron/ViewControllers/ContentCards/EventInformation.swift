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
    
    func loadData()  {
        signUpButton?.layer.cornerRadius = 7
        
        signupContainer?.layer.cornerRadius = 7
        dateContainer?.layer.cornerRadius = 7
        mapContainer?.layer.cornerRadius = 7
        contContainer?.layer.cornerRadius = 7
        descriptionContainer?.layer.cornerRadius = 7
        mapView?.layer.cornerRadius = 7
        descriptionView?.layer.cornerRadius = 7
        
        mapView?.centerCoordinate = CLLocationCoordinate2DMake(39.659996, -86.197870)
        mapView?.camera.altitude = 2000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
