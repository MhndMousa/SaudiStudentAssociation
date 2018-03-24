//
//  StoreTableViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {

    var fetchedInformation = NSDictionary()
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

        
        ref.child("Store").observeSingleEvent(of: .value, with: { (snapshot) in
            

            
            self.fetchedInformation = snapshot.value as! NSDictionary
            print(snapshot.value)
            print(self.fetchedInformation)
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.refresher.endRefreshing()
            })
            
        })  { (error) in
            print(error.localizedDescription)
            self.refresher.endRefreshing()
        }
    }
    

  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardArticleCell
        

        
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
