//
//  UIViewController + Extension.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = "Error", message: String = "Something went wrong") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    
    func updateNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.notoKufiArabicSmall]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white ,.font: UIFont.notoKufiBoldArabicExtraLarge]
            navBarAppearance.backgroundColor = .blueSSA
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
        
    func addReloadingIndicator(for seconds: TimeInterval) {
        let indicator = UIActivityIndicatorView()
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        indicator.widthAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        
        DispatchQueue.main.async {
            indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
                indicator.removeFromSuperview()
                indicator.stopAnimating()
            })
            
        }
    }
    
}
