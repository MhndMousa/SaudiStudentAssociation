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

    @IBAction func infoButtonTapped(_ sender: Any) {
            showAlert(title: "ما غرض هذه الصفحة؟", message: "هذه الصفحة يعرض بها النادي السعودي في المدينة عن الفعاليات القادمة")
    }
    // MARK:  Variables

    var events : [CardInformaion]  = []
    
    lazy var colors :[String:UIColor] = {
        var dic = [String:UIColor]()
        dic["pink"] =  UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1)
        dic["white"] = .white
        dic["blue"] = .blue
        dic["orange"] = .orange
        dic["black"] = .black
        return dic
        
    }()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestCalenderData), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var timer : Timer = {
        let timer = Timer()
        return timer
    }()
    
    
    
    
    // MARK:  UIViewController Config
      
      func updateStyle()  {
                  self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "NotoKufiArabic-Bold", size: 34)!,  NSAttributedStringKey.foregroundColor : UIColor.white]
      }
     
      override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardHighlightCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.refreshControl = refresher
        addReloadingIndicator(for: 1)
        refreshCurrentUserInfo()
        requestCalenderData()
        updateNavBar()
        updateStyle()
      }
    
    
    
    
    
    // MARK:  Networking
  
    @objc func requestCalenderData() {
        events.removeAll()
        ref.child("Store").observe(.childAdded) { (snapshot) in
            
            let dic  = snapshot.value! as! [String: AnyObject]
            let card = CardInformaion(dic, self.colors)
            card.cardId = snapshot.key
            
//
////            Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//            Storage.storage().reference().child("test/a3716125247_16.jpg")
//                .getData(maxSize: 1 * 1024 * 1024) {data, error in
//                        if  error != nil{
//                        } else {
//                            let a = UIImage(data: data!)
//                            card.image = a!
//                        }
//                    }

            
            self.events.insert(card, at: 0)
            self.events.sort{ $0.time.intValue > $1.time.intValue}
            
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.handleDataReload), userInfo: nil, repeats: false)
        }
    }
    
    
    
    
    
    // MARK:  TableView Delegates
    
    @objc func handleDataReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.refresher.endRefreshing()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: CardHighlightCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardHighlightCell
//        let event = self.events[indexPath.row]
//
//        let cardVC :EventInformation = {
//            let e = EventInformation()
//            e.dateLabel?.text = String(describing: indexPath.row)
//            return e
//        }()
//
//
//        DispatchQueue.main.async {
//            cell.populate(event)
//            cardVC.dateLabel?.text = String(describing: indexPath.row)
//            cardVC.loadViewIfNeeded()
//            cardVC.viewDidLayoutSubviews()
//        }
//
//        cell.event = cardVC
//        cell.card?.shouldPresent(cell.event, from: self, fullscreen: true)
//
//        cell.selectionStyle = .none
//        cell.backgroundColor = UIColor(hex: "efeff4")


        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.events[indexPath.row].title
        cell.textLabel?.font = .notoKufiBoldArabicMedium
        
        cell.detailTextLabel?.text = "\(self.events[indexPath.row].userID)"
        cell.detailTextLabel?.font = .notoKufiArabicSmall
        
        cell.imageView?.image = self.events[indexPath.row].icon
        cell.imageView?.clipsToBounds = true
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventInformation()
        vc.title = self.events[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
}


