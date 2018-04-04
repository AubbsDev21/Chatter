//
//  AddChannelViewController.swift
//  Chatter
//
//  Created by Aubre Body on 3/26/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase

class AddChannelViewController: UIViewController {
    var ref: DatabaseReference!
    
    let SubmitButton: UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 6), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(CreateChannelHandlerButton), for: .touchUpInside)
        return button
    }()
    
   
    let textField: UITextField = {
       let text = UITextField()
        text.placeholder = "Enter A Topic"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.backgroundColor = UIColor.white
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 8
       
        return text
    }()
    
    
    let label: UILabel = {
       let text = UILabel()
        text.text = "Create A Channel"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 30)
        text.textColor = UIColor.white
        text.textAlignment = .center
        return text
    }()
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        let images = UIImage(named: "pic1")
        view.image = images
        
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        
        visualEffectView.frame = view.bounds
        visualEffectView.backgroundColor = UIColor.clear
        
        view.addSubview(backgroundImage)
        view.addSubview(visualEffectView)
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(SubmitButton)
       setup()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Channels", style: .plain, target: self, action: #selector(BackHandler))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.lightGray
    }
    
    @objc func BackHandler() {
        dismiss(animated: true, completion: nil)
    }
    
    func setup(){
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 69).isActive = true
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        label.heightAnchor.constraint(equalToConstant: 89).isActive = true
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 288).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        SubmitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SubmitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        SubmitButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        SubmitButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
    }
    
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
    
}
