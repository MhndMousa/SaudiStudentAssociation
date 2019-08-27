//
//  ViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/15/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseUI



class ContactViewController: UICollectionViewController{

    
    var roaster = [SaudiUser]()
    
    @IBAction func signOutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let userDefault = UserDefaults.standard
            
//            let email = userDefault.string(forKey: "email")
//            let password = userDefault.string(forKey: "password")
            userDefault.removeObject(forKey: "email")
            userDefault.removeObject(forKey: "password")
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "login")
            self.present(vc, animated: true, completion: nil)
            justLoggedOut = true
        }catch let error as NSError{
            print(error)
        }
    }

    
    func reloadRoasterData(){
        roaster.removeAll()
        _ = ref.child("clubs").child("IN").child("indianapolis").child("roaster").observe(.value) { (snapshot) in
            let values = snapshot.value as! NSDictionary
            for value in values.allValues{
                let userInfoFromFirebase = value as! [String : String]
                self.roaster.append(SaudiUser(userInfoFromFirebase))
                print(self.roaster)
            }
            self.collectionView?.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadRoasterData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: "ContactCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roaster.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ContactCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactCardCell
        
        let user = roaster[indexPath.row]
        cell.nameLabel.text = user.name
        cell.jobLabel.text = user.job ?? " "
        cell.imageView.sd_setImage(with: URL(string: user.imageLink), placeholderImage: #imageLiteral(resourceName: "Unknown_Person"))
        cell.whatsAppNumber =   user.phoneNumber
        
        return cell
    }

}





extension ContactViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.view.bounds.width / 2) - 6
        
        return CGSize(width: cellWidth, height: cellWidth * 1.75)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let insets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
//        return insets
//    }

    
    
}
