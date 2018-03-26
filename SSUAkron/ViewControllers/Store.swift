//
//  StoreTableViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

class StoreTableViewController: UITableViewController {

    var fetchedInformation = [CardInformaion]()
    var imageArray = [UIImage]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardArticleCell", bundle: nil), forCellReuseIdentifier: "cell")
         requestData()
        print("viewWillApear Loaded")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        addBlurStatusBar(view: self)
        imageArray = [#imageLiteral(resourceName: "car1"),#imageLiteral(resourceName: "car3"),#imageLiteral(resourceName: "car2")]
        
        
        
        
        
        tableView.refreshControl = refresher
        self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "NotoKufiArabic-Bold", size: 34)!,  NSAttributedStringKey.foregroundColor : UIColor.white]
        
    }
    
    
    // MARK: - Refresher data source
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
        
    }()
    
    
    @objc func requestData() {

        fetchedInformation.removeAll()
        print("Event count Before: " + String (fetchedInformation.count))
        
        // TODO: Change the refrence to the Calander Event child in firebase
        ref.child("Store").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                var dic  = child.value! as! [String: Any]
                let card = CardInformaion()
                
                //TODO: Add the rest of the data that populates the card
                card.title = dic["title"] as! Int
                card.itemTitle = dic["itemTitle"] as! Int
                card.itemSubtitle = dic["itemSubtitle"] as! Int
                self.fetchedInformation.insert(card, at: 0)
                
                //                print(dic)
                //                print(self.events.count)
                
            }
            print("in store")
            
            //
            print("Event count After: " + String (self.fetchedInformation.count))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                self.refresher.endRefreshing()
                self.tableView.reloadData()
            })
        })
        
        
        
    }
    

  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardArticleCell
        cell.backgroundColor = UIColor(hex: "efeff4")
        
        if cell == CardArticleCell(){
            
        }else{
            
            cell.card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
            cell.card.backgroundImage = imageArray[0]
            
            cell.card.title = "كامري"
            cell.card.subtitle = "وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف"
            cell.card.category = "سيارة"
            
            cell.card.textColor = UIColor.white
            
            
            let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "StoreCard")
            cell.card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            //        cell.addSubview(card)
        }

        
        cell.card.shadowOpacity = 0
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Row count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedInformation.count
    }
    
    // Cell Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



