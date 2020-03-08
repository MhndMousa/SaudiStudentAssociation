//
//  Date+Extension.swift
//  BoringSSL-GRPC
//
//  Created by Muhannad Alnemer on 3/8/20.
//

import Foundation
extension Date {
    // Get how many (ofComponent) between two dates provided
    // How to use: Date().interval(ofComponent: .day or .month or .year,  formDate: Date())
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
    
    var year:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    var day :String{
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.string(from: self)
    }
    var minutes: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
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
