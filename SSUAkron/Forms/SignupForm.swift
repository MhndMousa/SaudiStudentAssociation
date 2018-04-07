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
    
    @IBAction func submitTapped(_ sender: Any) {
    
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "الاسم"
            }
            <<< TextRow(){row in
                row.title = "الايميل"
                row.placeholder = "example@example.com"
        }
            <<< PasswordRow(){ row in
                row.title = "كلمة المرور"
        }
            <<< PasswordRow(){ row in
                row.title = "تأكيد كلمة المرور"
        }
        
    }
    
}
