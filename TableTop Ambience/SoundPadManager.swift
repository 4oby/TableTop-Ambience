//
//  SoundPadManager.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 9/1/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation


private let globalPadListKey = "allPadsAreSavedUnderMe"

final class SoundPadManager: NSObject {
    
    static let sharedInstance = SoundPadManager()
    var padList = [String]()
    
    override init() {
        super.init()
        self.initPadList()
    }
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
            return encodedPads.map({ SoundPadItem(dictionary: $0) })
        }
        return nil
    }
    
    func savePad(pad: [SoundPadItem], named: String, append: Bool = true) {
        var sureName = named
            if append {
                sureName = ensureEligibleName(named)
                padList.append(sureName)
                savePadList()
            }
            UserDefaults.standard.setValue(pad.map({ $0.encode() }), forKey: sureName)
    }
    
    func removePadNamed( _ name: String) {
        if padList.contains(name) {
            padList.removeObject(object: name)
            UserDefaults.standard.setValue(nil, forKey: name)
            savePadList()
        }
    }
    
    func removePadAtIndex(_ index: Int) {
        UserDefaults.standard.set(nil, forKey: padList[index])
        padList.remove(at: index)
        savePadList()
    }
    
    func renamePad(index: Int, newPadName: String) {
        let oldPadName = padList[index]
        if let pad = getPad(oldPadName) {
            removePadAtIndex(index)
            let eligibleNewName = ensureEligibleName(newPadName)
            savePad(pad: pad, named: eligibleNewName, append: false)
            padList.insert(eligibleNewName, at: index)
            savePadList()
        }
    }
}

//MARK: - InternalFunctions
extension SoundPadManager {
     func ensureEligibleName(_ name: String) -> String {
        if padList.contains(name) {
            return  ensureEligibleName(name + "Copy")
        }else {
            return name
        }
    }
}

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

