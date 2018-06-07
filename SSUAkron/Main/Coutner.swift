//
//  ViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/15/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MKRingProgressView



class CounterViewController: UIViewController {
    @IBOutlet weak var ringView: MKRingProgressView!
    @IBOutlet weak var dateCounter: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var s : Int = 0
    var isSalaryUpdated: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSalary()
        ringView?.progress = 1.0
        
        // If the salary is not updated update it after a second from the time the view was loaded.
        if isSalaryUpdated {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.updateCircle()
            })
        }
    
        
        // Rendering a white background for the circle.
        let render = UIGraphicsImageRenderer(size: CGSize(width: ringView.frame.width, height: ringView.frame.height))
        let img = render.image { (ctx) in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            let rectangle = CGRect(x: 0, y: 0, width: ringView.frame.width, height: ringView.frame.width)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fill)
            }
        imageView.image =  img
        
        
    }

    // converts number of a range of two numbers into another range of  two numbers
    func map(minRange:Float, maxRange:Float, minDomain:Float, maxDomain:Float, value:Float) -> Double {
        return Double(minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange))
    }
    
    // Updates the MKCircleProgressBar
    func updateCircle() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.5)
        // Assign how many days to the progress bar of the ring
        self.ringView?.progress = self.map(minRange: 0, maxRange: 30, minDomain: 0, maxDomain: 1, value: Float(30 - self.s))
        CATransaction.commit()
        isSalaryUpdated = false
    }
    
    func updateSalary() {
        var d = Date()
        var num = 0
        
        // Loops to find how many days until the 27th of the month.
        while(true){
            d = Date(timeIntervalSinceNow: TimeInterval(num))
            print(Calendar.current.component(.day, from: d))
            if Calendar.current.component(.day, from: d) == 27 {
                s = d.interval(ofComponent: .day, fromDate: Date() )
                break
            }
            // Adds a 86400 seconds = (1 day)
            num = num + 86400
        }
        dateCounter?.text = String(s)
        isSalaryUpdated = true
        
        /*
        dateCounter?.text = String("durra")
        if d.interval(ofComponent: .day, fromDate: Date() ) == 0 {
            dateCounter?.text = "يوم الراتب"
            daysLabel.isHidden = true
        }else{
            dateCounter?.text = String(s)
            daysLabel?.isHidden = false
        }
        */
 }
}


extension Date {
    // Get how many (ofComponent) between two dates provided
    // How to use: Date().interval(ofComponent: .day or .month or .year,  formDate: Date())
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}


