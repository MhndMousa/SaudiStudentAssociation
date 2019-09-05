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
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBAction func submitTapped(_ sender: Any) {
        
        // Check for admin premission then post to firebase
        
        print("tapped")

    }
    
    let locationManager = CLLocationManager()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    var randomArray = ["فعالية رياضية" , "فعالية نسائية", "فعالية اجتماعية", "فعاليات اخرى"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter
        
       
        
        form +++ Section()
            
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.placeholder = "اختر عنوان الفعالية"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = .notoKufiArabicSmall
                    cell.detailTextLabel?.font = .notoKufiArabicSmall
                })
            
            <<< PushRow<String>() {
                $0.title = "نوع الفعالية"
                $0.selectorTitle = "اختر نوع الفعالية"
                $0.options = randomArray
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = .notoKufiArabicSmall
                    cell.detailTextLabel?.font = .notoKufiArabicSmall
                })
            <<< TextAreaRow(){
                $0.placeholder = "وصف للفعالية"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = .notoKufiArabicSmall
                    cell.detailTextLabel?.font = .notoKufiArabicSmall
                })
                    

            
            +++ Section()
            <<< IntRow(){
                $0.title = "المبلغ"
                $0.placeholder = "ادخل المبلغ بالدولار"
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
    
            +++ Section(footer: "في حال عدم اضافة صورة سوف يتم استخدام صورة النادي السعودي الاصلية لاعلان الفعالية")
            
            <<< TextRow(){ row in
                row.title = "اسم الموقع"
                row.placeholder = "اختر اسم الموقع"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = .notoKufiArabicSmall
                    cell.detailTextLabel?.font = .notoKufiArabicSmall
                })
    
            <<< TextRow(){ row in
                row.title = "وصف الموقع"
                row.placeholder = "مثال : الغرفة رفم 4 الطابق 2"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = .notoKufiArabicSmall
                    cell.detailTextLabel?.font = .notoKufiArabicSmall
                })

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
}
extension EventPostFormViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        
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
    class var notoKufiArabicSmall: UIFont {return UIFont(name: "NotoKufiArabic", size: 12)!}
    class var notoKufiArabicMedium: UIFont {return UIFont(name: "NotoKufiArabic", size: 15)!}
    class var notoKufiArabicMediumLarge: UIFont {return UIFont(name: "NotoKufiArabic", size: 18)!}
    class var notoKufiArabicLarge: UIFont {return UIFont(name: "NotoKufiArabic", size: 21)!}
    
    class var notoKufiBoldArabicSmall: UIFont {return UIFont(name: "NotoKufiArabic-Bold", size: 12)!}
    class var notoKufiBoldArabicMedium: UIFont {return UIFont(name: "NotoKufiArabic-Bold", size: 15)!}
    class var notoKufiBoldArabicMediumLarge: UIFont {return UIFont(name: "NotoKufiArabic-Bold", size: 18)!}
    class var notoKufiBoldArabicLarge: UIFont {return UIFont(name: "NotoKufiArabic-Bold", size: 21)!}
    
}
