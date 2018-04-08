//
//  LoginViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/28/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import TransitionButton
import Firebase

var justLoggedOut = false
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var rectangleView: UIView!
    let button = TransitionButton()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userDefault = UserDefaults.standard
        if !justLoggedOut && userDefault.string(forKey: "email") != nil && userDefault.string(forKey: "password") != nil{
            let email = userDefault.string(forKey: "email")
            let password = userDefault.string(forKey: "password")
            login(email: email!, password: password!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
    
    
    func initView(){
        rectangleView.layer.cornerRadius = 20
        usernameTextField.layer.cornerRadius = 5
        passwordTextFeild.layer.cornerRadius = 5
        
        
        button .frame =  CGRect(x: self.view.frame.width / 2 - 50 , y: self.view.frame.height - 100, width: 100, height: 40)
        button.backgroundColor = UIColor(hex: "167CAA")
        button.setTitle("تسجيل دخول", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    @IBAction func buttonAction() {
        let email = self.usernameTextField.text!
        let password = self.passwordTextFeild.text!
        login(email: email, password: password)
    }

    func login(email : String, password : String){
        self.button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            sleep(3) // 3: Do your networking task or background work here.
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.button.stopAnimation(animationStyle: .shake, completion: nil)
                    })
                }else{
                    DispatchQueue.main.async(execute: { () -> Void in
                            self.button.stopAnimation(animationStyle: .expand, completion: {
                            
                            let userDefault = UserDefaults.standard
                            userDefault.setValue(email, forKey: "email")
                            userDefault.setValue(password, forKey: "password")

                            let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "main")
                            self.present(secondVC, animated: true, completion: nil)
                        })
                    })
                }
            })
 
        })
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField{
            passwordTextFeild.becomeFirstResponder()
        }else if textField == passwordTextFeild{
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

