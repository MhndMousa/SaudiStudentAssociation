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
    @IBAction func infoButtonTapped(_ sender: Any) {
            showAlert(title: "ما غرض هذه الصفحة؟", message: "كثير منا ما يعرف مين هم القائمين على النادي السعودي، هذه الصفحة غرضها معرفة لائحة النادي وطريقة التواصل معاهم")
    }
    
    
    var roaster = [SaudiUser]()
    
    func reloadRoasterData(){
        
        addReloadingIndicator(for: 1)
        roaster.removeAll()
        
        
        
        ref.child("clubs").child("IN").child("indianapolis").child("roaster").observe(.value) { (snapshot) in
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
        super.viewWillAppear(animated)
        reloadRoasterData()
        self.collectionView?.register(UINib(nibName: "ContactCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Some", for: .normal)
        button.titleLabel?.font = .notoKufiBoldArabicMedium
        button.setImage(#imageLiteral(resourceName: "icons8-expand-arrow-96-2"), for: .normal)
        button.imageView?.anchor(trailing: button.titleLabel?.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2), size: .init(width: 17, height: 17))
        
        let stackview = UIStackView(arrangedSubviews:  [button])
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .center
        stackview.spacing = 4
        
        self.navigationItem.titleView = stackview
    }
  

}


extension ContactViewController: UICollectionViewDelegateFlowLayout{
    
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
}
