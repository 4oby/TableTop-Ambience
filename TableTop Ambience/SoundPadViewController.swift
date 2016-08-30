//
//  ViewController.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/19/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit


class SoundPadViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSoundPad = [SoundFlow]()
    var editModeEnabled = false

    
    //MARK: - Navigation bar actions

    @IBAction func editButtonTapped(_ sender: AnyObject) { //for some strange reason I cannot place this in an extension >_<
        
       toogleEditMode()
    }
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {

        SoundPicker(self).delegate = self
    }
    
    
    //MARK: - ToolBarItemActions
    
    @IBAction func loadSoundPad(_ sender: AnyObject) {
        loadASoundPad()
    }
    
    @IBAction func saveSoundPad(_ sender: AnyObject) {
        
    }
}

//MARK: - InternalFunctions
extension SoundPadViewController{
    
    func removeCell(_ sender: AnyObject) {
        //!!!: I don't like this being here, there must be another way
        currentSoundPad.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func toogleEditMode() {
        
        if editModeEnabled == false {
            editButton.title = "Done"
            editButton.style = .done
            editModeEnabled = true
            
            self.navigationItem.leftBarButtonItem = nil
        }else {
            
            editButton.style = .plain
            editButton.title = "Edit"
            editModeEnabled = false
            
            self.navigationItem.leftBarButtonItem = addButton
        }
        
        collectionView.reloadData()
    }
    
    // load/save mb use some DEMON
    func loadASoundPad() {
        //show list of savedSoundPads, chose1, restore
    }
    
    func saveCurrentSoundPad() {
        //save current soundpadState
    }
}

//MARK: - SoundPickerDelegate
extension SoundPadViewController: SoudPickerDelegate {
    
    func soundPickerDidSelect(_ sound: String?) {

        currentSoundPad.append(SoundFlow(baseItem: SoundPadItem(fileAddress: sound ?? "")))
        collectionView.reloadData()
    }
}


//MARK: - CollectionViewDataSource
extension SoundPadViewController: UICollectionViewDataSource {

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
        cell.deleteButton.tag = indexPath.row
        currentSoundPad[indexPath.row].delegate = cell
        
        if currentSoundPad[indexPath.row].baseItem.autoRepeat {
            //FIXME: find a better solution, changing cells here sucks
            cell.repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96-highlight"), for: .normal)
        }
        
        if editModeEnabled {
            
            cell.deleteButton.isHidden = false
            cell.deleteButton.addTarget(self,
                                        action: #selector(self.removeCell(_:)),
                                        for: .touchUpInside)
            cell.iconImage.isHidden = true
        }else {
            
            cell.deleteButton.isHidden = true
            cell.iconImage.isHidden = false
        }
        
        return cell
    }
}

