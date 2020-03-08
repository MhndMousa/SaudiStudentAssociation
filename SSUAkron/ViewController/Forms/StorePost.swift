//
//  Post.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/26/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import Eureka
import ImageRow
import MapKit

class StorePostFormViewController: FormViewController, CLLocationManagerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    var typeChoicesArray = ["مركبة" , "اثاث منزل", "الكترونيات", "مستلزمات دراسية", "اخرى"]
    
    // TODO: Check cells for correct input
    func checkCells() -> Bool {
        return true
    }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TODO: Validate every input from the user before submission
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.tag = "title"
                row.placeholder = "اختر عنوان السعلة"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
            })
            
            <<< PushRow<String>() {
                $0.title = "نوع السلعة"
                $0.tag = "catagory"
                $0.selectorTitle = "اختر نوع السلعة"
                $0.options = typeChoicesArray
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
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
                $0.tag = "description"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
            })
            
            +++ Section(footer: "سوف يتم استخدام هذا الرقم للسماح للاخرين بالتواصل معك عن طريق الواتساب")
            <<< IntRow(){
                $0.title = "المبلغ"
                $0.tag = "price"
                $0.placeholder = "ادخل المبلغ بالدولار"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
            })
            <<< PickerInlineRow<String>(){
                $0.title = "اريد الملبغ في"
                $0.tag = "location"
                $0.options = ["السعودية", "بلد الدراسة"]
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
            })
            <<< PhoneRow(){
                $0.title = "رقم التواصل"
                $0.tag = "whatsapp"
                $0.placeholder = "+1 317 123-4567"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
            }.cellSetup({ (cell, row) in
                cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
            })
    }
}

// MARK: Handlers

extension StorePostFormViewController{
    
    @IBAction func submitTapped(_ sender: Any) {
        
        // Post to firebase procedure
        guard checkCells() else {return}
        
        // Get values from the form
        var formValues = self.form.values()
        
        if let userID = Auth.auth().currentUser?.uid {
            // Make refrence in the storage and the database for the photo and the post
            let userIDStorageRef = storageRef.child("store").child(userID)    // Storage: Store -> uid
            let newPostKey = ref.child("Store").childByAutoId().key!                     // Databse: Store -> random_post
            let imageRef =  userIDStorageRef.child(newPostKey).child("image1.jpg")      // Storage: Store -> uid -> random_post -> image name
            
            // Add poster ID for to get to them when contacting via chat
            formValues["uid"] = userID
            
            // TODO: for loop for each photo in an array
            //       Send all at one, or one by one??
            //       Inside the if statement or ouside??
            if let img = formValues["picture"] as? UIImage{
                print(img.size)
                
                // Convert Image into data and prepare for upload
                if let imageData = UIImageJPEGRepresentation(img, 0.8){
                    
                    // Uploads the image
                    let uploadTask = imageRef.putData(imageData)
                    
                    // Observe upload progress
                    uploadTask.observe(.progress) { (snapshot) in
                        let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                        print("Completed: \(percentComplete)")
                    }
                    
                    // Assign the picture path to the form to save it in the database
                    let imageArray: [String:Any] = ["count" : "5", "image1" : imageRef.fullPath]
                    formValues["picture"] = imageArray as! [String:String]
                    
                    
                    // If the upload is successful
                    uploadTask.observe(.success) { (snapshot) in
                        
                        // Post the data with new reassigned location for the picture to the database
                        ref.child("Store").child(newPostKey).setValue(formValues)
                        ref.child("Store").child(newPostKey).updateChildValues(["uid":userID])
                        print("Post uploaded")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "هل متاكد من اغلاق الاعلان", message: "في حال اغلاقك الصفحة سوف تخسر جميع المعلومات المدخلة حالياً", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "اغلاق", style: .destructive, handler: { alert in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "اكمل التعديل", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
