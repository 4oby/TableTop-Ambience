//
//  SoundManager.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/22/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation

private let resourcesRootFolder = "Sound"
private let resourcesFileType = "mp3"

enum SoundCategories: String {
    case ambient = "Ambient",
         music   = "Music",
         sfx     = "SFX",
         special = "Special"
    
    static let allValues = [ambient, music, sfx, special]
}

final class SoundManager: NSObject {
    
    static let sharedInstance = SoundManager()
    var soundList = [[String]]()
    
    override init() {
        super.init()
        self.loadFileList()
    }
}

//MARK: - Init the soundList
extension SoundManager {
    func loadFileList() {
        for category in SoundCategories.allValues {
            let filesFromCurrentCategory = Bundle.main.paths(forResourcesOfType: resourcesFileType,
                                                             inDirectory: resourcesRootFolder + "/" + category.rawValue)
            soundList.append(filesFromCurrentCategory)
        }
    }
    
    func getSoundListForCategory(category: SoundCategories) -> [String]? {
        return soundList[category.hashValue]
    }
    
    func getSoundListForCategory(number: Int) -> [String]? {
        return soundList[number]
    }
}

