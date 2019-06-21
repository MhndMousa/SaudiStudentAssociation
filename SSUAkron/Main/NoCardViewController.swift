//
//  NoCardViewController.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 6/17/19.
//  Copyright © 2019 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

class NoCardViewController: UITableViewController {
    
    var fetchedInformation = [CardInformaion]()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresher
        
        self.tableView.register(UINib(nibName: "NoCardTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    
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
            print("After loop")
            print(self.fetchedInformation)
        })
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoCardTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = StoreInformation()
        present(vc, animated: true) {
            print(self.fetchedInformation[indexPath.row])
//            vc.costLabel.text = String(describing: indexPath.row)
            DispatchQueue.main.async {
                
                vc.costLabel.text = self.fetchedInformation[indexPath.row].title
                vc.descriptionView.text = "this is some other stuff that I just I making up"
            }
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
