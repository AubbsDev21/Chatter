//
//  ChannelViewController.swift
//  Chatter
//
//  Created by Aubre Body on 3/26/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
class ChannelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var channels = [Channel]()
    var test: [String] = ["goat","jfjfjdjjd","jfjd","fkkd","jejej","kfkfk"]
    var Picture: [String] = ["pic1","pic2","pic3","pic4","pic5","pic6","pic7","pic8","pic9","pic10"]
    let cellID = "cellID"
    var ref: DatabaseReference!
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        Checkifuserislogedin()
        fetchUser()
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "plus_icon"), style: .plain, target: self, action: #selector(Addchannelsegueway))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(LogoutHandler))
    }
    @objc func LogoutHandler() {
        //signing the current user out of fire base
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error singing out: %@", signOutError)
        }
        /////end///////
        performSegue(withIdentifier: "LoginSeuge", sender: nil)
    }
    
    @objc func Addchannelsegueway(){
       let vc = AddChannelViewController()
        let newController = UINavigationController(rootViewController: vc)
        present(newController, animated: true, completion: nil)

    }
    
    func fetchUser(){
        ref = Database.database().reference()
        let query = ref.child("channels").queryOrdered(byChild: "Channelname")
        query.observe(.value, with: { (DataSnapshot) in
            for child in DataSnapshot.children.allObjects as! [DataSnapshot]{
                if let value = child.value as? NSDictionary {
                    print(DataSnapshot)
                    let channel = Channel()
                    let Channelname = value["Channelname"] as? String ?? "Channel name not found"
                    
                    channel.uid = child.key
                    channel.name = Channelname
                    self.channels.append(channel)
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        }, withCancel: nil)
        
    }
    
    func showChatlog(channel: Channel) {
        let layout = UICollectionViewFlowLayout()
        let viewController = ChatViewController(collectionViewLayout: layout)
        let newController = UINavigationController(rootViewController: viewController)
        viewController.channel = channel
        present(newController, animated: true, completion: nil)
    }
    
    func Checkifuserislogedin() {
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "LoginSeuge", sender: nil)
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

  

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomChannelCell
        let name = channels[indexPath.row]
          cell.channelLabel?.text = name.name
          cell.cellview.layer.cornerRadius = cell.cellview.frame.height / 2
          cell.channelpic?.image = UIImage(named: Picture[indexPath.row])
        cell.channelpic.layer.masksToBounds = true
        cell.channelpic.layer.cornerRadius = 40
        // Configure the cell...

        return cell
    }
    

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let Channel = self.channels[indexPath.row]
        showChatlog(channel: Channel)
        
            //self.performSegue(withIdentifier: "ShowChannel", sender: channel)
       
        
    }
   
   

}
