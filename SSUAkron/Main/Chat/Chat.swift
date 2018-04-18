//
//  ChatLogController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/13/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit


class ChatLogController: UITableViewController {

    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()

    }
    
    func fetchUsers(){

        let messagesRef = ref.child("users").child(currentUser.uid!).child("messages")
        
        messagesRef.observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
            }
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text =  "Test"
        return cell
    }
}
