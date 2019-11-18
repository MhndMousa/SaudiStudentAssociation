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
import GooglePlaces
import FirebaseDatabase

//import <GooglePlaces/GooglePlaces.h>

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
    var place : GMSPlace!
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
//    func 
    
    @IBAction func submitTapped(_ sender: Any) {
        
        
        // Check fields are the correct ones
        
        
        
        
        
        // Check for admin premission then post to firebase
        var formValues = form.values()
        
        var locationInfo : [String : Any] = [
            "coordinates" : ["long" : self.place.coordinate.longitude, "lat" : self.place.coordinate.latitude],
            "name" : self.place.name,
            "subtitle" : self.form.rowBy(tag: "location_description")?.baseValue as? String ,
            "id" : self.place.placeID,
        ]
        
        print(locationInfo)
        
        if let icon = EventCatagoryToIconName(){
            formValues["icon"]  = icon
        }
        
        formValues.merge(locationInfo) { (current, _) -> Any? in current}
        print(formValues)
        
        
        
        
        
        let calender = Calendar.current
        
        // Deconstruct the date from the row
        let a = form.rowBy(tag: "date")?.baseValue as! Date
        formValues["date"] = "\(calender.component(.month, from: a))/\(calender.component(.day, from: a))/\(calender.component(.year, from: a))"
        
        // Deconstruct the time from the row
        let b = form.rowBy(tag: "date")?.baseValue as! Date
        formValues["time"] = "\(calender.component(.hour, from: b)):\(calender.component(.minute, from: b))"

        formValues.forEach({
            print("K:", $0, "V:", $1)
        })
        
        
        
        
        
        
        
//        ref.child("posts").childByAutoId().setValue(formValues)
        ref.child("Event").childByAutoId().setValue(formValues) { (error, _) in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.showAlert(title: "خطأ", message: "\(error?.localizedDescription)")
            }
        }
    }
    
    let locationManager = CLLocationManager()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barTintColor = .blueSSA
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    var randomArray = [ "فعالية رياضية" , "فعالية نسائية" , "فعالية اجتماعية" , "فعاليات اخرى" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        autocompleteController.autocompleteFilter = filter
        
        
        form +++ Section()
            
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.placeholder = "اختر عنوان الفعالية"
                row.tag = "title"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
            <<< PushRow<String>() {
                $0.title = "نوع الفعالية"
                $0.selectorTitle = "اختر نوع الفعالية"
                $0.options = randomArray
                $0.tag = "catagory"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< TextAreaRow(){
                $0.placeholder = "وصف للفعالية"
                $0.tag = "eventDescription"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
            
            +++ Section()
            <<< DateRow(){
                $0.title = "تاريخ الفعالية"
                $0.tag = "date"
                $0.value = Date()
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
//                    /                    cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< TimeRow(){
                $0.title = "وقت الفعالية"
                $0.tag = "time"
                $0.value = Date()
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
//                    /                    cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< IntRow(){
                $0.title = "رسوم دخول الفعالية"
                $0.placeholder = "ادخل المبلغ بالدولار"
                $0.tag = "cost"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< IntRow(){
                $0.title = "عدد المقاعدة المتاحة"
                $0.placeholder = "0"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
//                     +++ Section(footer: "في حال عدم اضافة صورة سوف يتم استخدام صورة النادي السعودي الاصلية لاعلان الفعالية")
            
            +++ Section()
            <<< ButtonRow(){row in
                row.title = "اختر موقع الفعالية"
                row.tag = "location"
            }.onCellSelection({ (cell, row) in
                // Display the autocomplete view controller.
                self.present(autocompleteController, animated: true, completion: nil)
            }).cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
            <<< TextRow(){ row in
                row.title = "الاسم"
                row.placeholder = ""
                row.tag = "location_name"
                row.disabled = true
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
            <<< TextRow(){ row in
                row.title = "المدينة"
                row.placeholder = ""
                row.tag = "location_city"
                row.disabled = true
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            
            <<< TextRow(){ row in
                row.title = "الولاية"
                row.placeholder = ""
                row.tag = "location_state"
                row.disabled = true
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< TextRow(){ row in
                row.title = "البلد"
                row.placeholder = ""
                row.tag = "location_country"
                row.disabled = true
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })
            <<< TextRow(){ row in
                row.title = "الرمز البريدي"
                row.placeholder = ""
                row.tag = "postal_code"
                row.disabled = true
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })

            
            <<< TextRow(){ row in
                row.title = "وصف الموقع"
                row.tag = "location_description"
                row.placeholder = "مثال : الغرفة رفم 4 الطابق 2"
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = .notoKufiArabicSmall
                cell.detailTextLabel?.font = .notoKufiArabicSmall
            })

            
        
        
//            <<< LocationRow(){row in
//                row.title = "موقع الفعالية"
//
//                DispatchQueue.main.async {
//                    self.locationManager.startUpdatingLocation()
//                    if let coordinates = self.locationManager.location?.coordinate{
//                          row.value = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
//                    }
//                }
//                }.cellSetup({ (cell, row) in
//                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                })

        
//            <<< ImageRow(){
//                $0.title = "صورة"
//                $0.sourceTypes = [.PhotoLibrary, .Camera]
//                $0.clearAction = .yes(style: UIAlertActionStyle.destructive)
//                }.cellUpdate({ (cell, row) in
//                    cell.accessoryView?.layer.cornerRadius = 17
//                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//                }).cellSetup({ (cell, row) in
//                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                })
        

            
    }
    
    func EventCatagoryToIconName() -> String? {
        let rowString = form.rowBy(tag: "catagory")?.baseValue
        switch rowString as? String {
               case "فعالية رياضية":  return "sports"
               case "فعالية نسائية":  return "woman"
               case "فعالية اجتماعية": return "message"
               case "فعاليات اخرى": return "none"
               default: return nil
        }
    }
}
extension EventPostFormViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place ID: \(place.placeID)")
//        print(place.addressComponents?.map({$0.name}))
//        print(place.addressComponents?.map({$0.types}))
//        print(place.addressComponents?.map({$0.shortName}))
//        print(place.addressComponents?.filter({if ($0.types.contains("locality"){return $0.name}}))
        
        self.place = place
        
        
        let city        = place.addressComponents?.first(where: {$0.types.contains("locality")})?.name
        let county      = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_2")})?.name
        let state       = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_1")})?.name
        let country     = place.addressComponents?.first(where: {$0.types.contains("country")})?.name
        let postal_code = place.addressComponents?.first(where: {$0.types.contains("postal_code")})?.name
        let administrat = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_3")})?.name
        
        
//        print("Place ID: \(place.addressComponents?.filter({ $0.name == "city" }))")
        
        form.rowBy(tag: "location_name")?.baseValue = place.name?.localizedCapitalized
        form.rowBy(tag: "location_city")?.baseValue = city
        form.rowBy(tag: "location_state")?.baseValue = state
        form.rowBy(tag: "location_country")?.baseValue = country?.localizedCapitalized
        form.rowBy(tag: "postal_code")?.baseValue = postal_code
        
        
        form.rowBy(tag: "location_name")?.updateCell()
        form.rowBy(tag: "location_city")?.updateCell()
        form.rowBy(tag: "location_state")?.updateCell()
        form.rowBy(tag: "location_country")?.updateCell()
        form.rowBy(tag: "postal_code")?.updateCell()
//        let rows = self.form.allRows.filter({$0.title == "" || $0.tag == })
//        cell.title = "\(place.name!)"

        
        self.loadViewIfNeeded()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension UIFont{
    class var notoKufiArabicSmall: UIFont           {return UIFont(name: "NotoKufiArabic", size: 12)!}
    class var notoKufiArabicMedium: UIFont          {return UIFont(name: "NotoKufiArabic", size: 15)!}
    class var notoKufiArabicMediumLarge: UIFont     {return UIFont(name: "NotoKufiArabic", size: 18)!}
    class var notoKufiArabicLarge: UIFont           {return UIFont(name: "NotoKufiArabic", size: 21)!}
    class var notoKufiArabicExtraLarge: UIFont      {return UIFont(name: "NotoKufiArabic", size: 34)!}
    
    class var notoKufiBoldArabicSmall: UIFont       {return UIFont(name: "NotoKufiArabic-Bold", size: 12)!}
    class var notoKufiBoldArabicMedium: UIFont      {return UIFont(name: "NotoKufiArabic-Bold", size: 15)!}
    class var notoKufiBoldArabicMediumLarge: UIFont {return UIFont(name: "NotoKufiArabic-Bold", size: 18)!}
    class var notoKufiBoldArabicLarge: UIFont       {return UIFont(name: "NotoKufiArabic-Bold", size: 21)!}
    class var notoKufiBoldArabicExtraLarge: UIFont  {return UIFont(name: "NotoKufiArabic-Bold", size: 34)!}
    
}
//
//extension UIColor{
//    class var SSAblue: UIFont  {return UIFont(name: "NotoKufiArabic-Bold", size: 34)!}
//}

