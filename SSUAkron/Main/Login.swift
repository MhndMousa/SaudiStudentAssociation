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
    @IBOutlet weak var loginButtonContainer: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var rectangleView: UIView!
    var loginButton : TransitionButton = {
        let button = TransitionButton()
        button.backgroundColor = UIColor(hex: "2F82AB")
        button.setTitle("تسجيل دخول", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoKufiArabic", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 5
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    
    fileprivate func gotToMain(){
        let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "main")
        self.present(secondVC, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tryLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawLoginButton()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func googleSignInButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
        // Adding a loading UIView to show that networking in the background
        let indicator = UIActivityIndicatorView()
        let loadingView = UIView()
        
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loadingView)
        
        // Adding a white overlay on the current page
        loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        loadingView.backgroundColor = .white
        loadingView.alpha = 0.8

        // Add loading indicator
        loadingView.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.color = .blue
        indicator.startAnimating()

        
        // Animating the indicator
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            sleep(8)
            DispatchQueue.main.async(execute: { () -> Void in
                if Auth.auth().currentUser != nil{
                    self.gotToMain()
                }
                // Delete the white overlay
                loadingView.removeFromSuperview()
                print(Auth.auth().currentUser?.email! as Any)
            })
        })
    }
    
    

    func drawLoginButton(){
        loginButtonContainer.backgroundColor = .clear
//        rectangleView.layer.cornerRadius = 5
        usernameTextField.layer.cornerRadius = 5
        passwordTextFeild.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
        
        
        // Update login button style
        let point = self.signUpButton.frame.center
        loginButton.frame =  CGRect(x: self.view.frame.width / 2 - 50 ,
                                y: point.y + 20,
                                width: 100, height: 50)
        loginButtonContainer.addSubview(loginButton)
        
        // Adding constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginButtonContainer.topAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginButtonContainer.bottomAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: loginButtonContainer.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: loginButtonContainer.trailingAnchor).isActive = true
    }

    
    // If the user logged in before then login them in automatically.
    func tryLogin() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
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

    @IBAction func loginButtonAction() {
        let email = self.usernameTextField.text!
        let password = self.passwordTextFeild.text!
        login(email: email, password: password)
    }

    func login(email : String, password : String){
        self.loginButton.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
        backgroundQueue.async(execute: {
            sleep(3) // 3: Do your networking task or background work here.
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.loginButton.stopAnimation(animationStyle: .shake, completion: nil)
                    })
                }else{
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.loginButton.stopAnimation(animationStyle: .expand, completion: {
                            // Add user default for the email and password for to loging automatically after
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

