//
//  TableViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController, UINavigationBarDelegate {
 
    @IBOutlet weak var cardCell: CardHighlight!
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

//        print("stuff")
//        let deadline = DispatchTime.now() + .milliseconds(1000)
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//
//        }
        
    
        
        ref.child("Store").observeSingleEvent(of: .value, with: { (snapshot) in
        
            let value = snapshot.value as! NSDictionary
            let one = value["time"] as? String ?? ""
            print(one)
             self.refresher.endRefreshing()
        })  { (error) in
            print(error.localizedDescription)
             self.refresher.endRefreshing()
        }
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return wrapContent(cell: self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        return 320
    }

    
    
}


