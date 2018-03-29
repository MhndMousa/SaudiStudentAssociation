//
//  LoginViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/28/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import TransitionButton

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = TransitionButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height - 200, width: 100, height: 40))
        self.view.addSubview(button)
        
        button.backgroundColor = .white
        button.setTitle("تسجيل دخول", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .blue
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
            
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ button: TransitionButton) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
