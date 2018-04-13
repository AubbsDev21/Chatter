<h1 align="center"> Chatter </h1> <br>

<p align="center">
  <a href="">
    <img alt="Chatter" title="Chatter" src="https://user-images.githubusercontent.com/16025198/38326439-d1b09f3a-3813-11e8-8971-a4cafa82bd22.png" width="250">
  </a>
</p>
<p align="center">This a anonymous group messaging app</p>
<br>
<br>

## Overview
Chatter is a anonymous topic chat IOS application. Where a user can create a topic and chat with multiplue end users. Where I implemented Firebase to save, fetch data and authenticate users.

## Screenshots
![iphonech](https://user-images.githubusercontent.com/16025198/38756356-35d02628-3f37-11e8-821a-479b989af916.png)


## Code Examples
Authenticate users anonymously
```bash
  func regSigninbutton() {
        Auth.auth().signInAnonymously { (User, Error) in
            
            if Error != nil {
                print(Error?.localizedDescription)
                return
            }
          
        }
       performSegue(withIdentifier: "Navsegue", sender: nil)
    }
```
Fetching Users
```bash
 
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
```
Saving Users to the database
```bash
 @objc func CreateChannelHandlerButton() {
        guard let channel = textField.text else {
            return
        }
        ref = Database.database().reference()
        let channelref = ref.child("channels").childByAutoId()
        let value = ["Channelname": channel]
        channelref.setValue(value)
        
        textField.text = ""
    }
```
