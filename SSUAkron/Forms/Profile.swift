//
//  profileViewContoller.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/8/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Firebase

class ProfileViewContoller: FormViewController {
    
    @IBAction func submitTapped(_ sender: Any) {
        let values = form.values()
        let db = ref.child("users").child(currentUser.uid!)
        db.updateChildValues(values) { (error, ref) in
            print(error)
        }
        refreshCurrentUserInfo()
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        form +++ Section()
            <<< ImageRow(){ row in
                row.title = "صورة شخصية"
                row.tag = "image"
                }.cellUpdate({ (cell, row) in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            +++ Section("معلومات شخصية")
            <<< TextRow(){row in
                row.title = "الاسم"
                row.tag = "name"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    if currentUser.name != nil {
                        row.value = currentUser.name
                    }
                })
            <<< TextRow(){ row in
                row.title = "الجامعة"
                row.tag = "university"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    if currentUser.university != nil {
                        row.value = currentUser.university
                    }
                    
                })
            <<< TextRow(){ row in
                row.title = "التخصص"
                row.tag = "major"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    if currentUser.major != nil{
                        row.value = currentUser.major
                    }
                })
            <<< PhoneRow(){row in
                row.title = "رقم الهاتف"
                row.tag = "phone_number"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    if currentUser.phoneNumber != nil{
                        row.value = currentUser.phoneNumber
                    }else{
                        row.placeholder = "+1 (123)123-1234"
                    }
                })
            
            +++ Section( "الملف الشخصي")
            <<< TextRow(){row in
                row.title = "الايميل"
                row.tag = "email"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    if currentUser.email != nil{
                        row.value = currentUser.email
                    }
                })
            <<< PasswordRow(){ row in
                row.title = "كملة المرور"
                row.tag = "password"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< PasswordRow(){ row in
                row.title = "تاكيد كلمة المرور"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
        
            <<< ButtonRow(){row in
                row.title = "تسجيل الخروج"
                }.onCellSelection({ (_, _) in
                    do{
                        try Auth.auth().signOut()
                        let userDefault = UserDefaults.standard
                        userDefault.set(false, forKey: "loggedIn")
                        let vc = self.storyboard!.instantiateViewController(withIdentifier: StorybaordID.login.rawValue)
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                        justLoggedOut = true
                        
                    }catch let error as NSError{
                        print(error)
                    }
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })

    }
    
    
    
}
