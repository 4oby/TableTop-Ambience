//
//  ViewController.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/19/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    

    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSoundPad = [SoundFlow]()
    var editModeEnabled = false
    
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
    
    
    //MARK: - Navigation bar's editButtonFunction

    func deleteSoundPadCell(sender: UIButton) {
        
        let i: Int = (sender.layer.value(forKey: "index")) as? Int ?? 0
        
        currentSoundPad.remove(at: i)
        collectionView.reloadData()
    }

    @IBAction func editButtonTapped(_ sender: AnyObject) { //for some strange reason I cannot place this in an extension >_<
        
        if editModeEnabled == false {
            editButton.title = "Done"
            editButton.style = .done
            editModeEnabled = true
            
            for cell in collectionView.visibleCells as! [SoundPadCell] {
                
                cell.deleteButton.isHidden = false
                cell.deleteButton.addTarget(self,
                                            action: #selector(self.removeCell(_:)),
                                            for: .touchUpInside)
                cell.iconImage.isHidden = true
            }
        }else {
        
            editButton.style = .plain
            editButton.title = "Edit"
            editModeEnabled = false
            
            for cell in collectionView.visibleCells as! [SoundPadCell] {
                
                cell.deleteButton.isHidden = true
                cell.iconImage.isHidden = false
            }
            
        }
    }
    
    func removeCell(_ sender: AnyObject) {
        
        currentSoundPad.remove(at: sender.tag)
        collectionView.reloadData()
        
    }
}


//MARK: - CollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSoundPad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: SoundPadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! SoundPadCell
        cell.tag = indexPath.row
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




