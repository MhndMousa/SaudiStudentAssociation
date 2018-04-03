//
//  StoreViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/19/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreViewController: UITableViewController {


    
    var imageArray = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurStatusBar(view: self)
        imageArray = [#imageLiteral(resourceName: "car1"),#imageLiteral(resourceName: "car3"),#imageLiteral(resourceName: "car2")]
        tableView.refreshControl = refresher
        self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "NotoKufiArabic-Bold", size: 34)!,  NSAttributedStringKey.foregroundColor : UIColor.white]

        
        
    }

    
    
    
    
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
//            print(one)
            self.refresher.endRefreshing()
        })  { (error) in
//            print(error.localizedDescription)
            self.refresher.endRefreshing()
        }
    }
    
    
    
    
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let card = CardArticle(frame: CGRect(x: 10, y: 30 , width: view.frame.width - 20 , height: 240))
        
        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
        card.backgroundImage = imageArray[1]
        
        card.title = "كامري"
        card.subtitle = "وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف"
        card.category = "سيارة"
        
        card.textColor = UIColor.white
        card.hasParallax = true
        
        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "StoreCard")
        card.shouldPresent(cardContentVC, from: self, fullscreen: false)
        
        cell.addSubview(card)
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return wrapContent(cell: self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        return 320
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
