//
//  SoundPadPicker.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 9/2/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import UIKit

protocol SoundPadPickerDelegate: class {
    
    func soundPadPickerDidSelect(_ padName: String?)
}

class SoundPadPicker: NSObject {
    
    weak var delegate: SoundPadPickerDelegate?
    weak var parent: UIViewController?
    var alertController: UIAlertController?
    
    init(_ parent: UIViewController) {
        super.init()
        self.parent = parent
        self.delegate = parent as? SoundPadPickerDelegate
    }
    
    func start(_ lastSelected: Int = 0) {
        
        preconfigureAlertController()
        showAlertWithItems(items: SoundPadManager.sharedInstance.padList)
    }
    
   private func preconfigureAlertController() {
        
        alertController = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        alertController?.addAction(cancelAction)
    }
    
    
   private func showAlertWithItems(items: [String]) {
        
        for index in 0..<items.count {
            
            let action = UIAlertAction(title:  items[index],
                                       style: .default,
                                       handler: { (action) in
                                        
                                            self.delegate?.soundPadPickerDidSelect(items[index])
            })

            alertController?.addAction(action)
        }
        
        parent?.present(alertController!, animated: true, completion: nil)
    }
}


