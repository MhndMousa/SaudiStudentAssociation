//
//  StoreTableViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/22/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class StoreTableViewController: UITableViewController {

    @IBAction func infoButtonTapped(_ sender: Any) {
        showAlert(title: "ما غرض هذه الصفحة؟", message: "هذه الصفحة متاحة لجميع من يريد عرض ممتلكاته الخاصة للبيع")
    }
    // MARK:  Variables

    private let cellId = "cell"
    var fetchedInformation = [StoreInformationModel]()
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
        addReloadingIndicator(for: 1)
        fetchedInformation.removeAll()
//        print("Event count Before: " + String (fetchedInformation.count))
        ref.child("Store").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let dic  = child.value! as! [String: Any]
                print(dic)
                let card = StoreInformationModel(dic as [String : AnyObject])
                self.fetchedInformation.insert(card, at: 0)

            }
        })
        print(fetchedInformation)
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.handleDataReload), userInfo: nil, repeats: false)
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FullPhotoTableViewCell
        let index = self.fetchedInformation[indexPath.row]
        cell.headlineLabel.text = index.title
        cell.catagory.text = index.catagory
        if let photoPath = index.photoPath{
            cell.backgroundImageView.sd_setImage(with: URL(string: "gs://ssuakron.appspot.com\(index.photoPath!)"))
        }
        print("index: ", index)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    // Row count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedInformation.count
    }
    
    // Cell Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoreInformation()
        let info = self.fetchedInformation[indexPath.row]
        vc.title = info.title
        vc.costString = info.cost
        vc.descriptionString = info.descriptionString
        vc.whereToRecieveString = info.whereToReceive
        vc.whatsAppNumber = info.whatsAppNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK:  ViewController methogs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresher
        self.tableView.register(UINib(nibName: "FullPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        updateNavBar()
        requestStoreData()
//        self.tableView.register(UINib(nibName: "CardArticleCell", bundle: nil), forCellReuseIdentifier: "cell")
//        self.tableView.register(FullPhotoTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}



