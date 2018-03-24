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
    
    var events = NSDictionary()
    var colors = [UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1), UIColor.blue, UIColor.orange]
    var cat = ["تجمع نسائي", "تجمع رجال " , "تجمع للاطفال"]
    
    
    
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
    
        
        ref.child("Store").observeSingleEvent(of: .value, with: { (snapshot) in
        
            self.events = snapshot.value as! NSDictionary
            let one = self.events["time"] as? String ?? ""
            print(one)
             self.refresher.endRefreshing()
        })  { (error) in
            print(error.localizedDescription)
             self.refresher.endRefreshing()
        }
    
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return wrapContent(cell: self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        return 320
    }

    var ss = 1
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let card = CardHighlight(frame: CGRect(x: 10, y: 15 , width: view.frame.width - 20 , height: 290))
    
        card.backgroundColor = UIColor(red: 10/255, green: 94/255, blue: 200/255, alpha: 1)
        card.icon = UIImage(named: "ssa")
        
        switch ss {
        case 1:
            card.title = "مسابقة \n النادي السعودي"
            card.itemTitle = "مباراة بين الفريق الفلاني وبرشلونة"
            card.itemSubtitle = "ايفينت رياضي"
            card.buttonText = "المزيد"
            card.textColor = UIColor.white
            ss = 2
        case 2:
        
            card.title = "افطار صائم"
            card.itemTitle = "تجمع الاسبوعي للافطار الجماعي"
            card.itemSubtitle = "ايفينت جماعي"
            card.buttonText = "المزيد"
            card.backgroundColor = UIColor(red: 60/255, green: 30/255, blue: 80/255, alpha: 1)
            card.textColor = UIColor.white
            ss = 3
        default:
            card.title = "حاجة ثانية "
            card.itemTitle = "وصف وصف وصف وصف"
            card.itemSubtitle = "ايفينت نسائي"
            card.buttonText = "المزيد"
            card.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0.7, alpha: 1)
            card.textColor = UIColor(white: 0.9, alpha: 1)
            ss = 1
        }

        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "EventCard")
        
        card.shouldPresent(cardContentVC, from: self, fullscreen: true)
        card.buttonTapped()
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.addSubview(card)
    
        
        
        return cell
        
    }
    
    
}


