//
//  SoundPicker.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/26/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import UIKit

protocol SoudPickerDelegate: class {
    func soundPickerDidSelect(_ sound: String?)
}

class SoundPicker: NSObject {
    
    var stepsLeft = 2 //Barbaric I know, but I heve not found a better way yet -_-
    
    weak var delegate: SoudPickerDelegate?
    weak var parent: UIViewController?
    var alertController: UIAlertController?
    
     init(_ parent: UIViewController) {
        super.init()
        self.parent = parent
        start()
    }
    
    func start(_ lastSelected: Int=0) {
        stepsLeft-=1
        preconfigureAlertController()
        
        switch stepsLeft { //???: will need to add an aditional step in case I eventually add a superCategory
        case 1:
            showAlertWithItems(items: SoundCategories.allValues.map({$0.rawValue}))
        case 0:
            showAlertWithItems(items: SoundManager.sharedInstance.getSoundListForCategory(number: lastSelected) ?? [""])
        default: break
        }
    }
    
    func preconfigureAlertController() {
        alertController = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
                                            self.delegate?.soundPickerDidSelect(nil)
        }
        alertController?.addAction(cancelAction)
    }
    
    
    func showAlertWithItems(items: [String]){
        
        for index in 0..<items.count {
            let action = UIAlertAction(title: stepsLeft != 0 ? items[index] : sanitaziTitle(title: items[index]),
                                       style: .default,
                                       handler: { (action) in
                                        if self.stepsLeft > 0 {
                                            self.start(index)
                                        }else {
                                            self.delegate?.soundPickerDidSelect(items[index])
                                        }
            })
            alertController?.addAction(action)
        }
        
        parent?.present(alertController!, animated: true, completion: nil)
    }
    
    
    func sanitaziTitle(title: String) -> String {
    return  URL(fileURLWithPath: title).deletingPathExtension().lastPathComponent
    }
    
}


