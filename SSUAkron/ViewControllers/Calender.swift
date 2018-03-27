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
    var cat = ["تجمع نسائي", "تجمع رجال " , "تجمع للاطفال"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UINib(nibName: "CardHighlightCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        requestData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        requestData()
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
        print("Event count Before: " + String (events.count))
        events.removeAll()
        ref.child("Store").observe(.childAdded) { (snapshot) in
            
            var dic  = snapshot.value! as! [String: Any]
            let card = CardInformaion()

            //TODO: Add the rest of the data that populates the card
            card.title = dic["title"] as? Int ?? 0
            card.itemTitle = dic["itemTitle"] as? Int ?? 0
            card.itemSubtitle = dic["itemSubtitle"] as? Int ?? 0
            let backgroundColor = dic["backgroundColor"] as? String ?? "white"
            card.backgroundColor = self.colors[backgroundColor]
            
            let photoRef = Storage.storage().reference().root().child("a3716125247_16.jpg")
            
            //Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                photoRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                    } else {
                        let image = UIImage(data: data!)
                        card.image = image!
                    }
                }
            
            self.events.insert(card, at: 0)
            printFuocused(a: self.events)
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

    var ss = 1
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        cell.card?.shadowOpacity = 0
        let event = self.events[indexPath.row]
        cell.card?.icon = UIImage(named: "ssa")
        
        DispatchQueue.main.async {
        cell.card?.title = String( describing: event.title!)
        cell.card?.itemTitle = String( describing: event.itemTitle!)
        cell.card?.itemSubtitle = String( describing: event.itemSubtitle!)
        cell.card?.backgroundColor = event.backgroundColor!
        cell.card?.icon = event.image
        }
        
        
       
        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "EventCard")
        cell.card?.shouldPresent(cardContentVC, from: self, fullscreen: true)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor(hex: "efeff4")
        return cell
        
    }
    
    
    
}

