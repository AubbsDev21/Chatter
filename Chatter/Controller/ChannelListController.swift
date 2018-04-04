//
//  ChannelListController.swift
//  Chatter
//
//  Created by Aubre Body on 3/13/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChannelListController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

       
    }

    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }


}
