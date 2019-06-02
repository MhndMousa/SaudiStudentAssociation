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
    
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBAction func cancelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "هل متاكد من اغلاق الاعلان", message: "في حال اغلاقك الصفحة سوف تخسر جميع المعلومات المدخلة حالياً", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "اغلاق", style: .destructive, handler: { alert in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "اكمل التعديل", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBAction func submitTapped(_ sender: Any) {
        // Post to firebase

        
        var formValues = self.form.values()
        
        print(formValues)
        
        // Take photo and upload it to storage first
//        let userStoreStorageRef = storageRef.child("store").child(currentUser.uid!)
        let userStoreStorageRef = storageRef.child("store")
        print("userStoreStorageRef: \(userStoreStorageRef)")
        
        let imageRef = userStoreStorageRef.child("image1.png")
        
        
        // File located on disk
        if let img = formValues["picture"] as? UIImage{
            print(img.size)
            
            if let imageData = UIImagePNGRepresentation(img){
                let uploadTask = imageRef.putData(imageData)
                let observer = uploadTask.observe(.progress) { (snapshot) in
                    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                    print("Completed: \(percentComplete)")
                }
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    formValues["picture"] = url
                }
            }
            
        }
        // get location of photo in storage here and reassign it
        formValues["picture"] = "photo location in storage"
        
        // pass data with new reassigned location for the picture
        ref.child("Store").childByAutoId().setValue(formValues)
        
  }
    
    var typeChoicesArray = ["مركبة" , "اثاث منزل", "الكترونيات", "مستلزمات دراسية", "اخرى"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.tag = "title"
                row.placeholder = "اختر عنوان السعلة"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            <<< PushRow<String>() {
                $0.title = "نوع السلعة"
                $0.tag = "catagory"
                $0.selectorTitle = "اختر نوع السلعة"
                $0.options = typeChoicesArray
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            <<< ImageRow(){
                $0.title = "صورة"
                $0.tag = "picture"
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.clearAction = .yes(style: UIAlertActionStyle.destructive)
                }.cellUpdate({ (cell, row) in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextAreaRow(){
                $0.placeholder = "وصف السلعة"
                $0.tag = "descrition"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            +++ Section()
            <<< IntRow(){
                $0.title = "المبلغ"
                $0.tag = "price"
                $0.placeholder = "ادخل المبلغ بالدولار"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< PickerInlineRow<String>(){
                $0.title = "اريد الملبغ في"
                $0.tag = "location"
                $0.options = ["السعودية", "بلد الدراسة"]
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
    }
}
