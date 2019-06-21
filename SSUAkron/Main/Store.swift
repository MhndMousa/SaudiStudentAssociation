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

    // MARK:  Variables

    var fetchedInformation = [CardInformaion]()
    var imageArray = [UIImage]()
    @IBOutlet weak var costLabel: UILabel!

    
    lazy var timer : Timer = {
        let timer = Timer()
        return timer
    }()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestStoreData), for: .valueChanged)
        
        return refreshControl
        
    }()
    
    // MARK:  Networking

    @objc func requestStoreData() {

        fetchedInformation.removeAll()
        print("Event count Before: " + String (fetchedInformation.count))
        
        ref.child("Store").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                
                let dic  = child.value! as! [String: Any]
                let card = CardInformaion(dic as [String : AnyObject])
                self.fetchedInformation.insert(card, at: 0)
            }
        })
        print(fetchedInformation)
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.handleDataReload), userInfo: nil, repeats: false)
        
    }

    
    // MARK:  TableView Config
    
    @objc func handleDataReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.refresher.endRefreshing()
        })
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardArticleCell
        cell.backgroundColor = UIColor(hex: "efeff4")
        let item = self.fetchedInformation[indexPath.row]
//        let cardContentVC = self.storyboard!.instantiateViewController(withIdentifier: "StoreCard")
        let cardContentVC = StoreInformation()
        
        DispatchQueue.main.async {
            cell.populate(item)
//            cardContentVC.costLabel?.text = String(describing: indexPath.row)
            cell.card.shouldPresent(cardContentVC, from: self, fullscreen: true)
        
            cardContentVC.costLabel.text = self.fetchedInformation[indexPath.row].userID
        }
        
        cell.selectionStyle = .none
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//
//
////        let indexPath = tableView.indexPathForSelectedRow
//        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! CardArticleCell
//        print("selected: \(cell)")
//
//        if #available(iOS 13.0, *) {
//            let StorePost = self.storyboard!.instantiateViewController(identifier: "Storinformation") as! StoreInformation
//            StorePost.costLabel.text = "10"
//            StorePost.whereToRecieveLabel.text = "any"
//            DispatchQueue.main.async {
//
//                cell.card.shouldPresent(StorePost, from: self)
//            }
//        } else {
//            performSegue(withIdentifier: "Storeinformation", sender: self)
//        }
//
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "main") as! StoreInformation
//        vc.costLabel.text = ""
//        vc.whereToRecieveLabel.text = "any"
//        cell.card.shouldPresent(vc, from: self)
//
//
//
//
//
//    }
    
    // MARK:  ViewController methogs
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardArticleCell", bundle: nil), forCellReuseIdentifier: "cell")
        requestStoreData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refresher
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont(name: "NotoKufiArabic-Bold", size: 34)!
            ,.foregroundColor : UIColor.white
        ]
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



