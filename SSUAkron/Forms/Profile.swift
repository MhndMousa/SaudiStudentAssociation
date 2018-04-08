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

let decoder = JSONDecoder()
//let user = try decoder.decode(Decodable.Protocol, from: Auth.auth().currentUser)


class ProfileViewContoller: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser)
        form +++ Section()
            <<< ImageRow(){ row in
                row.title = "صورة شخصية"
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
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextRow(){ row in
                row.title = "الجامعة"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextRow(){ row in
                row.title = "التخصص"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< PhoneRow(){row in
                row.title = "رقم الهاتف"
                row.placeholder = "+1 (123)123-1234"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            +++ Section( "الملف الشخصي")
            <<< TextRow(){row in
                row.title = "الايميل"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextRow(){ row in
                row.title = "كملة المرور"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< TextRow(){ row in
                row.title = "تاكيد كلمة المرور"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
        
    }
    
    
}
