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
    var colors = [UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1), UIColor.blue, UIColor.orange]
    var cat = ["تجمع نسائي", "تجمع رجال " , "تجمع للاطفال"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardHighlightCell", bundle: nil), forCellReuseIdentifier: "cell")
        
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
        print("Event count Before: " + String (events.count))
        
        // TODO: Change the refrence to the Calander Event child in firebase
        ref.child("Store").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                var dic  = child.value! as! [String: Any]
                let card = CardInformaion()
                
                
                
                //TODO: Add the rest of the data that populates the card
                card.title = dic["title"] as? Int ?? 0
                card.itemTitle = dic["itemTitle"] as? Int ?? 0
                card.itemSubtitle = dic["itemSubtitle"] as? Int ?? 0
                
                self.events.insert(card, at: 0)
                
                //                print(dic)
                //                print(self.events.count)
                
            }
            print("in store")
            
            //
            print("Event count After: " + String (self.events.count))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                self.refresher.endRefreshing()
                self.tableView.reloadData()
            })
        })
        
        
        
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return events.count
        return events.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return wrapContent(cell: self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        return 320
    }

    var ss = 1
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
//        print(init(descriping:indexPath))
        print(indexPath.row)
        var cell: CardHighlightCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardHighlightCell

//            ui.delegate = self
        
//        let cell : CardCell = (tableView.cellForRow(at: indexPath)  as? CardCell)!
//        let card = CardHighlight(frame: CGRect(x: 10, y: 15 , width: view.frame.width - 20 , height: 290))
//        cell.card?.backgroundColor = UIColor(red: 10/255, green: 94/255, blue: 200/255, alpha: 1)
//        cell.card?.icon = UIImage(named: "ssa")
//        switch ss {
//        case 1:
//            cell.card?.title = "مسابقة \n النادي السعودي"
////            cell.card.itemTitle = "مباراة بين الفريق الفلاني وبرشلونة"
////            cell.card.itemSubtitle = "ايفينت رياضي"
////            cell.card.buttonText = "المزيد"
//            cell.card?.textColor = UIColor.white
//            ss = 2
//        case 2:
////
//            cell.card?.title = "افطار صائم"
////            cell.card.itemTitle = "تجمع الاسبوعي للافطار الجماعي"
////            cell.card.itemSubtitle = "ايفينت جماعي"
////            cell.card.buttonText = "المزيد"
//            cell.card?.backgroundColor = UIColor(red: 60/255, green: 30/255, blue: 80/255, alpha: 1)
////            cell.card.textColor = UIColor.white
//            ss = 3
//        case 3:
//            cell.card?.title = "حاجة ثانية "
////            cell.card.itemTitle = "وصف وصف وصف وصف"
////            cell.card.itemSubtitle = "ايفينت نسائي"
////            cell.card.buttonText = "المزيد"
//            cell.card?.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0.7, alpha: 1)
////            cell.card.textColor = UIColor(white: 0.9, alpha: 1)
//            ss = 1
////
////
////            let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "EventCard")
////
////            cell.card.shouldPresent(cardContentVC, from: self, fullscreen: true)
////
////            cell.selectionStyle = UITableViewCellSelectionStyle.none
//        default:
//            print("default")
//
//        }

        
//    if cell == nil {
//        print("cell is nill")
//        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
//        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell") as! CardHighlightCell
//
//        }
//        cell.addSubview(card)
//        requestData()
//        print("cout: " + String(self.events.count))
        
        cell.card?.title = String( describing: self.events[indexPath.row].title!)
        cell.card?.itemTitle = String( describing: self.events[indexPath.row].itemTitle!)
        cell.card?.itemSubtitle = String( describing: self.events[indexPath.row].itemSubtitle!)
        
        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "EventCard")
        cell.card?.shouldPresent(cardContentVC, from: self, fullscreen: true)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    
    
}

