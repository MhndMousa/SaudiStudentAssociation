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
import GoogleSignIn


var justLoggedOut = false
class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var rectangleView: UIView!
    let button = TransitionButton()
    
    
    fileprivate func gotToMain(){
        let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "main")
        self.present(secondVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.gotToMain()
            }
        }
        
        let userDefault = UserDefaults.standard
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            if !justLoggedOut && userDefault.string(forKey: "email") != nil && userDefault.string(forKey: "password") != nil{
                self.gotToMain()
            }

        }
    }
    @IBAction func googleSignInButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        let indicator = UIActivityIndicatorView()
        let loadingView = UIView()
        let trButton = TransitionButton()
        
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loadingView)
        
        loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        loadingView.backgroundColor = .white
        loadingView.alpha = 0.8
        
        loadingView.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.color = .blue
        indicator.startAnimating()

       
        
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
        backgroundQueue.async(execute: {
            sleep(2)
            
            DispatchQueue.main.async(execute: { () -> Void in
                if Auth.auth().currentUser != nil{
                    self.gotToMain()
                }
                
                loadingView.removeFromSuperview()
            print(Auth.auth().currentUser?.email! as Any)
            })
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signInSilently()

    }
    
    @IBOutlet weak var transitionButtonContainer: UIView!
    
    func initView(){
        transitionButtonContainer.backgroundColor = .clear
        rectangleView.layer.cornerRadius = 20
        signUpButton.layer.cornerRadius = 20
        
        usernameTextField.layer.cornerRadius = 5
        passwordTextFeild.layer.cornerRadius = 5
        
        let point = self.signUpButton.frame.center
        print(point)
        button .frame =  CGRect(x: self.view.frame.width / 2 - 50 ,
                                y: point.y + 20,
                                width: 100, height: 50)

        button.backgroundColor = UIColor(hex: "167CAA")
        button.setTitle("تسجيل دخول", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoKufiArabic", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        transitionButtonContainer.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let top = button.topAnchor.constraint(equalTo: transitionButtonContainer.topAnchor)
        let bot = button.bottomAnchor.constraint(equalTo: transitionButtonContainer.bottomAnchor)
        let led = button.leadingAnchor.constraint(equalTo: transitionButtonContainer.leadingAnchor)
        let trail = button.trailingAnchor.constraint(equalTo: transitionButtonContainer.trailingAnchor)
        let buttonCon = [top, bot, led, trail]
        NSLayoutConstraint.activate(buttonCon)
//        self.view.addSubview(button)
        
        
    }
    @IBOutlet weak var signUpButton: UIButton!
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

                                self.gotToMain()
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

