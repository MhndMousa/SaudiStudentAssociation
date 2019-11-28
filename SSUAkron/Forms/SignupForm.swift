//
//  SignupForm.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/6/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//



import Firebase
import Eureka
import UIKit

class SignupForm: FormViewController {
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    
    
    func login(email :String , password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
             print(error)
            }else{
                let userDefault = UserDefaults.standard
                userDefault.setValue(email, forKey: "email")
                userDefault.setValue(password, forKey: "password")
                let secondVC = self.storyboard!.instantiateViewController(withIdentifier: StorybaordID.main.rawValue)
                secondVC.modalPresentationStyle = .fullScreen
                self.present(secondVC, animated: true, completion: nil)
            }
        }
    }
    @IBAction func submitTapped(_ sender: Any) {
        let valuesDictionary = form.values()
        print(valuesDictionary)
        for i in valuesDictionary {
            if i.value == nil{
                print(i)
                return
            }
        }
        let email = valuesDictionary["email"] as! String
        let password = valuesDictionary["password"] as! String
        Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
            if error != nil{
                print(error)
            } else{
                print("User is created:\(String(describing: user))")
                self.login(email: email, password: password)
            }
        })
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        for row in form.rows {
        //            row.
        //        }
        
        
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "الاسم"
                row.tag = "name"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            
//            <<< AlertRow<String>() { row in
//                row.title = "الجنس"
//                row.options = ["ذكر", "انثى"]
//                row.tag = "gender"
//                }.cellSetup({ (cell, row) in
//                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
//                })
            
            +++ Section()
            <<< EmailRow(){row in
                row.title = "الايميل"
                row.placeholder = "example@example.com"
                row.tag = "email"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesAlways
                
                }.cellSetup({ (cell, row) in
                    cell.titleLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = UIColor(hex: "db5858")
                        
                    }
            }
            
            <<< PasswordRow(){ row in
                row.title = "كلمة المرور"
                row.tag = "password"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
            <<< PasswordRow(){ row in
                row.title = "تأكيد كلمة المرور"
                row.tag = "password2"
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                    cell.detailTextLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
                })
    }
    
}
