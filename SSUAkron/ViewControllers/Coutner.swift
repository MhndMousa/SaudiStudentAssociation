//
//  ViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/15/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSalary()
        addBlurStatusBar(view: self)
        
    }
    
    
    @IBOutlet weak var dateCounter: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    func updateSalary()  {
        var d = Date()
        var s : Int = 0
        var num = 0
        while(true){
            d = Date(timeIntervalSinceNow: TimeInterval(num))
            print(Calendar.current.component(.day, from: d))
            if Calendar.current.component(.day, from: d) == 27 {
                s = d.interval(ofComponent: .day, fromDate: Date() )
                break
            }
            num = num + 86400
        }
        
        
        if d.interval(ofComponent: .day, fromDate: Date() ) == 0 {
            dateCounter?.text = "يوم الراتب"
            daysLabel.isHidden = true
        }else{
            dateCounter?.text = String(s)
            daysLabel.isHidden = false
        }
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


extension Date {

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}


