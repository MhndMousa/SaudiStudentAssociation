//
//  EventViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

var currentUser = SaudiUser()

class EventViewController: UITableViewController {

    var events = [CardInformaion]()
    var colors = ["pink" :UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1), "blue" : UIColor.blue, "orange" : UIColor.orange, "white" : UIColor.white, "black" : UIColor.black]
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardHighlightCell", bundle: nil), forCellReuseIdentifier: "cell")
        refreshCurrentUserInfo()
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
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
            
            let dic  = snapshot.value! as! [String: AnyObject]
            let card = CardInformaion(dic, self.colors)
            card.cardId = snapshot.key
            
            let photoRef = Storage.storage().reference().child("test/a3716125247_16.jpg")
//            Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    photoRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
                        if  error != nil{
                        } else {
                            let a = UIImage(data: data!)
                            card.image = a!
                        }
                    }
            
            self.events.insert(card, at: 0)
            self.events.sort(by: { (card1, card2) -> Bool in
                return card1.time.intValue > card2.time.intValue
            })
            
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.handleDataReload), userInfo: nil, repeats: false)
   
        }
    }
    
    var timer : Timer?
    @objc func handleDataReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.refresher.endRefreshing()
        })
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


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardId = self.events[indexPath.row].cardId!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CardHighlightCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardHighlightCell

        
        cell.card?.shadowOpacity = 0
        
        let cardVC = EventInformation()
        let event = self.events[indexPath.row]
        
//        let cardVC = UIViewController(nibName: "EventCard", bundle: nil) as! EventInformation
//        let cardVC = storyboard?.instantiateViewController(withIdentifier: "EventCard") as! EventInformation
        
        DispatchQueue.main.async {
            
            cell.card?.textColor = .white
            cell.card?.title = String( describing: event.title!)
            cell.card?.itemTitle = String( describing: event.itemTitle!)
            cell.card?.itemSubtitle = String( describing: event.itemSubtitle!)
            cell.card?.backgroundColor = event.backgroundColor!
            cell.card?.icon = event.image
            cell.card?.textColor = event.textColor!
            cardVC.dateLabel?.text = String(describing: indexPath.row)
            
            cardVC.loadViewIfNeeded()
            cardVC.viewDidLayoutSubviews()
        }
        


        cell.card?.shouldPresent(cardVC, from: self, fullscreen: true)
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor(hex: "efeff4")
        return cell
        
    }
    
    
    
}

var cardId = String()

