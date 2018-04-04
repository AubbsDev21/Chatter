//
//  CreateCell.swift
//  Chatter
//
//  Created by Aubre Body on 3/26/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
class CreateCell: UITableViewCell {
    var ref: DatabaseReference!
    @IBOutlet weak var Pictopic: UIButton!
    @IBOutlet weak var topicchannel: UITextField!
    @IBOutlet weak var addButton: UIButton!
   
    @IBAction func NewChannels(_ sender: Any) {
        var ref: DatabaseReference = Database.database().reference().child("channels")
        if let name = topicchannel.text {
            let newchannelref = ref.childByAutoId()
            let values = ["name": name]
            newchannelref.setValue(values)
            
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
