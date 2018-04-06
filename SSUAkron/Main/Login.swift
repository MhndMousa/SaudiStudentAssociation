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

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var rectangleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
    
    
    func initView(){
        rectangleView.layer.cornerRadius = 20
        usernameTextField.layer.cornerRadius = 5
        passwordTextFeild.layer.cornerRadius = 5
        
        let button = TransitionButton(frame: CGRect(x: self.view.frame.width / 2 - 50 , y: self.view.frame.height - 100, width: 100, height: 40))
        self.view.addSubview(button)
        
        button.backgroundColor = UIColor(hex: "167CAA")
        button.setTitle("تسجيل دخول", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
    }
    @IBAction func buttonAction(_ button: TransitionButton) {
        login(button)
    }

    func login(_ button : TransitionButton){
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
                    let secondVC = self.storyboard!.instantiateViewController(withIdentifier: "main")
                    self.present(secondVC, animated: true, completion: nil)
                })
            })
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

