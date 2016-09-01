//
//  SoundPadManager.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 9/1/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation


let globalPadListKey = "allPadsAreSavedUnderMe"

class SoundPadManager: NSObject {
    
    static let sharedInstance = SoundPadManager()
    
    var padList = [String]()
}

//MARK: - CRUD
extension SoundPadManager {
    
    func initPadList() {
        guard let padlist = UserDefaults.standard.array(forKey: globalPadListKey) else { return }
        self.padList = padlist as? [String] ?? [String]()
    }
    
    func savePadList() {
        UserDefaults.standard.setValue(padList, forKey: globalPadListKey)
    }
    
    
    func getPad(_ named: String) -> [SoundPadItem]? {
        
        if let encodedPads = UserDefaults.standard.array(forKey: named) as? [Dictionary<String, Any>]  {
            
            return encodedPads.map({SoundPadItem(dictionary: $0)})
        }
        
        return nil
    }
    
    func savePad(pad: [SoundPadItem], named: String) {
        
        UserDefaults.standard.setValue(pad.map({$0.encode()}), forKey: named)
        if !padList.contains(named) {
            
            padList.append(named)
            savePadList()
        }
    }
    
}
