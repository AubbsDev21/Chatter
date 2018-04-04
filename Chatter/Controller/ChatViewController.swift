//
//  ChatViewController.swift
//  Chatter
//
//  Created by Aubre Body on 3/27/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var ref: DatabaseReference!
    var messages = [Messages]()
    let cellId = "cellID"
    var channel: Channel? {
        didSet {
            navigationItem.title = channel?.name
            queryMesages()
        }
    }
    
    func queryMesages() {
        ref = Database.database().reference().child("Messages")
        ref.observe(.value, with: { (DataSnapshot) in
            for child in DataSnapshot.children.allObjects as! [DataSnapshot] {
                if let value = child.value as? NSDictionary {
                    let message = Messages()
                    let ChannelID = value["ChannelID"] as? String ?? ""
                    let text = value["message"] as? String ?? ""
                    let timestamp = value["timestamp"] as? NSNumber
                    let uid = value["uid"] as? String ?? ""
                    
                    message.ChannelID = ChannelID
                    message.message = text
                    message.timestamp = timestamp
                    message.uid = uid
                    
                    if message.ChannelID == self.channel?.uid {
                        self.messages.append(message)
                        
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                    
                    
                }
            }
        }, withCancel: nil)
        
        
    }

    let Containermessageinput: UIView = {
        let inputContainer = UIView()
        inputContainer.backgroundColor = UIColor.white
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return inputContainer
        
    }()
    
    let SendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEND", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(SendMessage_Handler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
   
    
    let MessageInput: UITextField = {
        let Input = UITextField()
        Input.placeholder = "Say Something...."
        Input.translatesAutoresizingMaskIntoConstraints = false
        
        return Input
    }()
    
    let SeperatorLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        NavBar()
        view.addSubview(Containermessageinput)
        view.addSubview(SeperatorLineView)
        messageContainer_setup()
        SepLine_setup()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.item]
        cell.textview.text = message.message
        
        cell.bubbleWidthAnchor?.constant = estimFrameForText(text: message.message!).width + 32
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        
        if let text = messages[indexPath.row].message {
            height = estimFrameForText(text: text).height + 25
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func messageContainer_setup() {
        Containermessageinput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Containermessageinput.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        Containermessageinput.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        Containermessageinput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        Containermessageinput.addSubview(SendButton)
        Containermessageinput.addSubview(MessageInput)
        print(SendButton)
        SendButton.rightAnchor.constraint(equalTo: Containermessageinput.rightAnchor).isActive = true
        SendButton.centerYAnchor.constraint(equalTo: Containermessageinput.centerYAnchor).isActive = true
        SendButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        SendButton.heightAnchor.constraint(equalTo: Containermessageinput.heightAnchor).isActive = true
        
        MessageInput.leftAnchor.constraint(equalTo: Containermessageinput.leftAnchor, constant: 8).isActive = true
        MessageInput.centerYAnchor.constraint(equalTo: Containermessageinput.centerYAnchor).isActive = true
        MessageInput.rightAnchor.constraint(equalTo: SendButton.leftAnchor).isActive = true
        MessageInput.heightAnchor.constraint(equalTo: Containermessageinput.heightAnchor).isActive = true
    }
    
    func SepLine_setup(){
        SeperatorLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SeperatorLineView.bottomAnchor.constraint(equalTo: Containermessageinput.topAnchor).isActive = true
        SeperatorLineView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        SeperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func NavBar() {
      // navigationController?.navigationBar.barTintColor = UIColor.clear
        let color = UIColor(red: 255/255, green: 138/255, blue: 216/255, alpha: 1)
        let textAttributes = [NSAttributedStringKey.foregroundColor:color]
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(BackHandler))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 138/255, blue: 216/255, alpha: 1)
        
    }
    
    @objc func SendMessage_Handler(){
        guard let text = MessageInput.text else {
            print("No text enter")
            return
        }
        ref = Database.database().reference().child("Messages")
        let childref = ref.childByAutoId()
        let Message = text
        let ChannelID = channel?.uid
        let uid = Auth.auth().currentUser?.uid
        let timestamp = NSDate().timeIntervalSince1970
        
        let value = ["message": Message, "ChannelID": ChannelID, "uid": uid,
                     "timestamp": timestamp] as [String : Any]
        childref.updateChildValues(value)
        
        MessageInput.text = ""
    }
    
    
    @objc func BackHandler() {
        dismiss(animated: true, completion: nil)
    }
}
