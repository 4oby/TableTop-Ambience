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
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSoundPad = [SoundFlow]()
    var editModeEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            dummyTest()
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
            
            self.navigationItem.leftBarButtonItem = nil
            
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
            
            self.navigationItem.leftBarButtonItem = addButton
            
            for cell in collectionView.visibleCells as! [SoundPadCell] {
                
                cell.deleteButton.isHidden = true
                cell.iconImage.isHidden = false
            }
            
        }
    }
    
    func removeCell(_ sender: AnyObject) {
    //!!!: I don't like this being here, there must be another way
        currentSoundPad.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    
    //MARK: - Navigation bar's addButtonFunction
    
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        print("Must add new item") //FIXME: This must be redone
        /*
        let alertController = UIAlertController(title: nil, message: "Select Category", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("mustCancel")
        }
        alertController.addAction(cancelAction)
        

        for cat in SoundCategories.allValues {
            let action = UIAlertAction(title: cat.rawValue, style: .default, handler: { (action) in
                print("selected cat: \(cat.rawValue)")
                
                let soundAlertController = UIAlertController(title: "Select Item", message: "", preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    print("mustCancel")
                }
                soundAlertController.addAction(cancelAction)
                
                for item in SoundManager.sharedInstance.getSoundListForCategory(category: cat)! {
                    let title: String = URL(fileURLWithPath: item).deletingPathExtension().lastPathComponent
                    let action = UIAlertAction(title: title,
                                               style: .default,
                                               handler: { (action) in
                        print(item)
                    })
                    soundAlertController.addAction(action)
                }
                self.present(soundAlertController, animated: true) {
                    // ...
                }

                
            })
            alertController.addAction(action)
        }
        
        
        self.present(alertController, animated: true) {
            // ...
        }
        */
        SoundPicker(self).delegate = self
        
            }
    
}

extension ViewController: SoudPickerDelegate {
    func soundPickerDidSelect(_ sound: String?) {
        print("a sound was selected: \(sound)")
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
            //FIXME: find a better solution, changing cells here sucks
            cell.repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96-highlight"), for: .normal)
        }
        
        return cell
    }
}

//MARK: - Kill me
extension ViewController {
    
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



