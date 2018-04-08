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
        print("tapped")
        
  }
    
    var randomArray = ["مركبة" , "اثاث منزل", "الكترونيات", "ملتزمات دراسية", "اخرى"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "العنوان"
                row.placeholder = "اختر عنوان السعلة"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
            <<< PushRow<String>() {
                $0.title = "نوع السلعة"
                $0.selectorTitle = "اختر نوع السلعة"
                $0.options = randomArray
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
            <<< TextAreaRow(){
                $0.placeholder = "وصف السلعة"
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
            <<< PickerInlineRow<String>(){
                $0.title = "اريد الملبغ في"
                $0.options = ["السعودية", "بلد الدراسة"]
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
    }
}
