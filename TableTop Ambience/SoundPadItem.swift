//
//  SoundPadItem.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/23/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation

struct SoundPadItem {
    
    let fileAddress: String
    let icon: String
    let name: String
    let autoRepeat: Bool
    let volume: Float
    
    init(fileAddress: String, icon: String, name: String, autoRepeat: Bool = false, volume: Float = 0.5) {
        
        self.fileAddress = fileAddress
        self.icon = icon
        self.name = name
        self.autoRepeat = autoRepeat
        self.volume = volume
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        self.fileAddress = dictionary["fileAddress"] as? String ?? ""
        self.icon = dictionary["icon"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.autoRepeat = dictionary["autoRepeat"] as? Bool ?? false
        self.volume = dictionary["volume"] as? Float ?? 0.5
    }
    
    init(fileAddress: String) { //utility init
        self.fileAddress = fileAddress
        self.icon = ""
        self.name = URL(fileURLWithPath: fileAddress).deletingPathExtension().lastPathComponent
        self.autoRepeat = false
        self.volume = 0.5
    }
    
}

//MARK: - Saving Utility
extension SoundPadItem {
    
    func encode() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        dictionary["fileAddress"] = self.fileAddress
        dictionary["icon"] = self.icon
        dictionary["name"] = self.name
        dictionary["autoRepeat"] = self.autoRepeat
        dictionary["volume"] = self.volume
        return dictionary
    }
}


//MARK: - Editing Utility
extension SoundPadItem {

    func setVolume(volume: Float) -> SoundPadItem {
        return SoundPadItem(fileAddress: self.fileAddress,
                            icon: self.icon,
                            name: self.name,
                            autoRepeat: self.autoRepeat,
                            volume: volume)
    }
    
    func setAutoRepeat(autoRepeat: Bool) -> SoundPadItem {
        return SoundPadItem(fileAddress: self.fileAddress,
                            icon: self.icon,
                            name: self.name,
                            autoRepeat: autoRepeat,
                            volume: self.volume)
    }
}

