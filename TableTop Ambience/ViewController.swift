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
    
    var currentSoundPad = [SoundFlow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            dummyTest()
    }

    func dummyTest() {
        
        for category in SoundManager.sharedInstance.soundList {
            for item in category {
                currentSoundPad.append(SoundFlow(baseItem: SoundPadItem(fileAddress: item,
                                                                        icon: "",
                                                                        name: URL(fileURLWithPath: item).deletingPathExtension().lastPathComponent)
                ))
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSoundPad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: SoundPadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! SoundPadCell
        cell.title.text = currentSoundPad[indexPath.row].baseItem.name
        cell.delegate = currentSoundPad[indexPath.row]
        cell.playStopButton.tag = indexPath.row
        
        if currentSoundPad[indexPath.row].baseItem.autoRepeat {
            //FIXME: find a better solution, cuz this suck
            cell.repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96-highlight"), for: .normal)
        }
        
        return cell
    }
}
