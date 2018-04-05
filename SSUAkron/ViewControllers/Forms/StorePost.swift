//
//  Post.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/26/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import ImageRow
import MapKit
class StorePostFormViewController: FormViewController, CLLocationManagerDelegate {
    
    
    var randomArray = ["مركبة" , "اثاث منزل", "الكترونيات", "ملتزمات دراسية", "اخرى"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationManager = CLLocationManager()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        let coordinates = locationManager.location?.coordinate

        form +++ Section()
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.placeholder = "اختر عنوان السعلة"
            }
            
            <<< PushRow<String>() {
                $0.title = "نوع السلعة"
                $0.selectorTitle = "اختر نوع السلعة"
                $0.options = randomArray
            }
            
            <<< ImageRow(){
                $0.title = "صورة"
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.clearAction = .yes(style: UIAlertActionStyle.destructive)
                }.cellUpdate({ (cell, row) in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                })
            <<< TextAreaRow(){
                $0.placeholder = "وصف السلعة"
            }
            
            +++ Section()
            <<< IntRow(){
                $0.title = "المبلغ"
                $0.placeholder = "ادخل المبلغ بالدولار"
            }
            <<< PickerInlineRow<String>(){
                $0.title = "اريد الملبغ في"
                $0.options = ["السعودية", "بلد الدراسة"]
        }
    }
}
