//
//  TableViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {

    var events = [CardInformaion]()
    var colors = ["pink" :UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1), "blue" : UIColor.blue, "orange" : UIColor.orange, "white" : UIColor.white]
    var eventType = ["تجمع نسائي", "تجمع رجال " , "تجمع للاطفال"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardHighlightCell", bundle: nil), forCellReuseIdentifier: "cell")
        requestData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        events.removeAll()
        ref.child("Store").observe(.childAdded) { (snapshot) in
            
            var dic  = snapshot.value! as! [String: Any]
            let card = CardInformaion()
            let storageRef =  Storage.storage().reference()
            
            //TODO: Add the rest of the data that populates the card
            card.title = dic["title"] as? Int ?? 0
            card.itemTitle = dic["itemTitle"] as? Int ?? 0
            card.itemSubtitle = dic["itemSubtitle"] as? Int ?? 0
            let backgroundColor = dic["backgroundColor"] as? String ?? "pink"
            card.backgroundColor = self.colors[backgroundColor]
            
            let photoRef = storageRef.child("test/a3716125247_16.jpg")
            //Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                photoRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if  error != nil{
                    } else {
                        let image = UIImage(data: data!)
                        card.image = image!
                    }
                }
            
            self.events.insert(card, at: 0)
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.refresher.endRefreshing()
            })
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return wrapContent(cell: self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        return 320
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CardHighlightCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardHighlightCell

        
        cell.card?.shadowOpacity = 0
        
        let cardVC = EventInformation()
        let event = self.events[indexPath.row]
        
        
        
        DispatchQueue.main.async {
            
            cell.card?.textColor = .white
            cell.card?.title = String( describing: event.title!)
            cell.card?.itemTitle = String( describing: event.itemTitle!)
            cell.card?.itemSubtitle = String( describing: event.itemSubtitle!)
            cell.card?.backgroundColor = event.backgroundColor!
            cell.card?.icon = event.image
            cardVC.dateLabel?.text = String(describing: indexPath.row)
            
        }
        


        cell.card?.shouldPresent(cardVC, from: self, fullscreen: true)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor(hex: "efeff4")
        return cell
        
    }
    
    
    
}

