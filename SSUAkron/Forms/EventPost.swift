//
//  EventPostFormViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/5/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import ImageRow
import MapKit

class EventPostFormViewController: FormViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    @IBAction func dismissTapped(_ sender: Any) {
        let alert = UIAlertController(title: "هل متاكد من اغلاق الاعلان", message: "في حال اغلاقك الصفحة سوف تخسر جميع المعلومات المدخلة حالياً", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "اغلاق", style: .destructive, handler: { alert in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "اكمل التعديل", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBAction func submitTapped(_ sender: Any) {
        
        // Check for admin premission then post to firebase
        
        print("tapped")

    }
    
    var randomArray = ["فعالية رياضية" , "فعالية نسائية", "فعالية اجتماعية", "فعاليات اخرى"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
       
        
        form +++ Section()
            
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.placeholder = "اختر عنوان الفعالية"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            <<< PushRow<String>() {
                $0.title = "نوع الفعالية"
                $0.selectorTitle = "اختر نوع الفعالية"
                $0.options = randomArray
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextAreaRow(){
                $0.placeholder = "وصف للفعالية"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            +++ Section()
            <<< IntRow(){
                $0.title = "المبلغ"
                $0.placeholder = "ادخل المبلغ بالدولار"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< IntRow(){
                $0.title = "عدد المقاعدة المتاحة"
                $0.placeholder = "0"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            
        
    
            
            +++ Section(footer: "في حال عدم اضافة صورة سوف يتم استخدام صورة النادي السعودي الاصلية لاعلان الفعالية")
            
            <<< TextRow(){ row in
                row.title = "اسم الموقع"
                row.placeholder = "اختر اسم الموقع"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextRow(){ row in
                row.title = "وصف الموقع"
                row.placeholder = "مثال : الغرفة رفم 4 الطابق 2"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< LocationRow(){row in
                row.title = "موقع الفعالية"
                
                DispatchQueue.main.async {
                    locationManager.startUpdatingLocation()
                    if let coordinates = locationManager.location?.coordinate{
                          row.value = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    }
                }
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< ImageRow(){
                $0.title = "صورة"
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.clearAction = .yes(style: UIAlertActionStyle.destructive)
                }.cellUpdate({ (cell, row) in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
        

            
    }
}
