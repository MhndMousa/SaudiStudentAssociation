//
//  ViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/15/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import MapKit



class ContactViewController: UICollectionViewController{

    
    var roaster = [User]()
    
    func loadData(){
        for i in 0...10 {
            let a = User()
            a.name = String(describing: i)
            roaster.append(a)
            if i % 2 == 0{
                a.job = "شسيب"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: "ContactCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        loadData()
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
        cell.jobLabel.text = user.job
        cell.imageView.image = user.image
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}





