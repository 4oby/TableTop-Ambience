//
//  SoundPadPicker.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 9/5/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import UIKit

private let reuseID = "SoundPickerReuse"

protocol SoundPadPickerDelegate: class {
    func soundPadPickerDidSelect(_ padName: String?)
}

final class SoundPadPicker: UITableViewController {

    weak var delegate: SoundPadPickerDelegate?
}


//MARK: - TableViewDataSource
extension SoundPadPicker {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SoundPadManager.sharedInstance.padList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = SoundPadManager.sharedInstance.padList[indexPath.row]
        return cell
    }
}


//MARK: - TableViewDelegate
extension SoundPadPicker {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
           self.delegate?.soundPadPickerDidSelect(SoundPadManager.sharedInstance.padList[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rename = UITableViewRowAction(style: .normal, title: "Rename") { action, index in
            let defaultName = SoundPadManager.sharedInstance.padList[indexPath.row]
            let alertController = UIAlertController(title: "Rename",
                                                    message: defaultName,
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            alertController.addTextField { (textField) in
                textField.text = defaultName
            }
            let rename = UIAlertAction(title: "Rename",
                                     style: .default) { (action) in
                                        if let textField = (alertController.textFields?[0]) ?? nil {
                                            SoundPadManager.sharedInstance.renamePad(index: indexPath.row, newPadName: textField.text ?? defaultName)
                                            tableView.reloadData()
                                        }
            }
            alertController.addAction(rename)
            self.present(alertController, animated: true)
        }
        rename.backgroundColor = .green
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            SoundPadManager.sharedInstance.removePadAtIndex(indexPath.row)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        return [delete, rename]
    }
}

