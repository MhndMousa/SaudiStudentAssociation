//
//  Salary.swift
//  Akron
//
//  Created by Muhannad Mousa on 3/19/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class Salary: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSalary()
    }
    
    
    
    
    

    @IBOutlet weak var dateCounter: UILabel!
//    @IBOutlet weak var daysLabel: UILabel!
    func updateSalary()  {
        var d = Date()
        var s : Int = 0
        var num = 0
        
        while(true){
            d = Date(timeIntervalSinceNow: TimeInterval(num))
            if Calendar.current.component(.day, from: d) == 27 {
                s = d.interval(ofComponent: .day, fromDate: Date() )
                break
            }
            num = num + 86400
        }
        
            dateCounter?.text = String(s)
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

