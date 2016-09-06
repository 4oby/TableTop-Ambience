//
//  ViewController.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/19/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit

private let loadPadSegueID = "loadSoundPad"

final class SoundPadViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSoundPad = [SoundFlow]()
    var editModeEnabled = false

    
    //MARK: - Navigation bar actions

    @IBAction func editButtonTapped(_ sender: AnyObject) {
       toogleEditMode()
    }

    @IBAction func addButtonTapped(_ sender: AnyObject) {
      SoundPicker(self).start()
    }
    
    
    //MARK: - ToolBarItemActions
    
    @IBAction func saveSoundPad(_ sender: AnyObject) {
        if currentSoundPad.count > 0 {
            saveCurrentSoundPad()
        }
    }
}

//MARK: - InternalFunctions
extension SoundPadViewController {

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
        } else {
            editButton.style = .plain
            editButton.title = "Edit"
            editModeEnabled = false
            self.navigationItem.leftBarButtonItem = addButton
        }
        collectionView.reloadData()
    }

    func saveCurrentSoundPad() {
        let defaultTitle = "Pad #" + String(Date().timeIntervalSince1970)
        let alertController = UIAlertController(title: nil,
                                                message: "Save current SoundBoard",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addTextField { (textField) in
            textField.text = defaultTitle
        }
        let save = UIAlertAction(title: "Save",
                                 style: .default) { (action) in
                                    if let textField = (alertController.textFields?[0]) ?? nil {
                                        SoundPadManager.sharedInstance.savePad(pad: self.currentSoundPad.map({$0.baseItem}), named: textField.text ?? defaultTitle)
                                    }
        }
        alertController.addAction(save)
        self.present(alertController, animated: true)
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
        let cell: SoundPadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as? SoundPadCell ?? SoundPadCell()
        cell.title.text = currentSoundPad[indexPath.row].baseItem.name
        cell.delegate = currentSoundPad[indexPath.row]
        cell.playStopButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        currentSoundPad[indexPath.row].delegate = cell
        
        if currentSoundPad[indexPath.row].baseItem.autoRepeat {
            cell.repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96-highlight"), for: .normal)
        }
        
        if editModeEnabled {
            cell.deleteButton.isHidden = false
            cell.deleteButton.addTarget(self,
                                        action: #selector(self.removeCell(_:)),
                                        for: .touchUpInside)
            cell.iconImage.isHidden = true
        } else {
            cell.deleteButton.isHidden = true
            cell.iconImage.isHidden = false
        }
            return cell
        }
}


//MARK - SoundPadPickerDelegate
extension SoundPadViewController: SoundPadPickerDelegate {
    func soundPadPickerDidSelect(_ padName: String?) {
        if let items = SoundPadManager.sharedInstance.getPad(padName ?? "") {
            currentSoundPad.removeAll()
            for item in items {
                currentSoundPad.append(SoundFlow(baseItem: item))
            }
            collectionView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == loadPadSegueID && segue.destination is SoundPadPicker {
            (segue.destination as? SoundPadPicker)?.delegate = self
        }
    }
}

