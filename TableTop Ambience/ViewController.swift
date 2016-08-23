//
//  ViewController.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/19/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
}


extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: SoundPadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! SoundPadCell

        return cell
    }
}
