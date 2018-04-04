//
//  ChatMessageCell.swift
//  Chatter
//
//  Created by Aubre Body on 3/28/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
class ChatMessageCell: UICollectionViewCell {
   
    let textview: UITextView = {
        let text = UITextView()
        text.text = "This is a text"
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.clear
        text.textColor = .white
        text.isEditable = false
        return text
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 70/255, green: 136/255, blue: 246/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    var bubbleWidthAnchor: NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textview)
        
        bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // cellSetup()
        //textview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7)
        textview.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 5).isActive = true
        textview.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
       // textview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textview.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true 
        textview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cellSetup() {
        textview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
}
