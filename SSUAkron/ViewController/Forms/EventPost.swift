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

class EventPostFormViewController: FormViewController, CLLocationManagerDelegate {
    
    var randomArray = [ "فعالية رياضية" , "فعالية نسائية" , "فعالية اجتماعية" , "فعاليات اخرى" ]
    var place : GMSPlace!
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    // MARK: ViewController Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barTintColor = .blueSSA
    }
    override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    
    // Specify the place data types to return.
    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue))!
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

            
    }
}

// MARK: - Handlers and Helpres

extension EventPostFormViewController{

        // MARK: Handlers
        

        @IBAction func dismissTapped(_ sender: Any) {
            let alert = UIAlertController(title: "هل متاكد من اغلاق الاعلان", message: "في حال اغلاقك الصفحة سوف تخسر جميع المعلومات المدخلة حالياً", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "اغلاق", style: .destructive, handler: { alert in
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "اكمل التعديل", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        @IBAction func submitTapped(_ sender: Any) {
            
            
            // Check fields are the correct ones
    //        guard checkCells() else { showAlert(title: "بوه شي ناقص", message: "تاكد انك كتبت في كل الخانات") ; return }
            
    //         Check for admin premission then post to firebase
            var formValues = form.values()
            let calender = Calendar.current
            
            // Deconstruct the date from the row
            let dateFromRow = form.rowBy(tag: "date")?.baseValue as! Date

            // Deconstruct the time from the row
            let timeFromRow = form.rowBy(tag: "time")?.baseValue as! Date
            formValues["time"] = "\(calender.component(.hour, from: timeFromRow)) : \(calender.component(.minute, from: timeFromRow))"
            let postId = ref.child("Store").childByAutoId().key!
            formValues["id"] = postId
            
            ref.child("Event").child(postId).setValue(formValues) { (error, ref) in
                if error == nil{
                    let date = NSNumber(value: dateFromRow.timeIntervalSince1970)
                    let time =  NSNumber(value: timeFromRow.timeIntervalSince1970)
                    ref.updateChildValues(["dates": date])
                    ref.updateChildValues(["times": time])
                    
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showAlert(title: "خطأ", message: "\(error?.localizedDescription)")
                }
            }
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


// MARK: - GMSAutocompleteViewControllerDelegate


extension EventPostFormViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.place = place
        let city        = place.addressComponents?.first(where: {$0.types.contains("locality")})?.name
        let county      = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_2")})?.name
        let state       = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_1")})?.name
        let country     = place.addressComponents?.first(where: {$0.types.contains("country")})?.name
        let postal_code = place.addressComponents?.first(where: {$0.types.contains("postal_code")})?.name
        let administrat = place.addressComponents?.first(where: {$0.types.contains("administrative_area_level_3")})?.name
        
        
        form.rowBy(tag: "location_name")?.baseValue = place.name?.localizedCapitalized
        form.rowBy(tag: "location_city")?.baseValue = city
        form.rowBy(tag: "location_state")?.baseValue = state
        form.rowBy(tag: "location_country")?.baseValue = country?.localizedCapitalized
        form.rowBy(tag: "postal_code")?.baseValue = postal_code
        
        // Show
        form.rowBy(tag: "location_name")?.updateCell()
        form.rowBy(tag: "location_city")?.updateCell()
        form.rowBy(tag: "location_state")?.updateCell()
        form.rowBy(tag: "location_country")?.updateCell()
        form.rowBy(tag: "postal_code")?.updateCell()
        
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
