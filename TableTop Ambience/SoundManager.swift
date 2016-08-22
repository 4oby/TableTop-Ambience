//
//  SoundManager.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/22/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import AVFoundation

let resourcesRootFolder = "Sound"
let resourcesFileType = "mp3"

enum SoundCategories: String {
    case ambient = "Ambient",
    music   = "Music",
    sfx     = "SFX",
    special = "Special"
    
    static let allValues = [ambient, music, sfx, special]
}

class SoundManager: NSObject {
    static let sharedInstance = SoundManager()
    internal var soundList = [[String]]()
    var audioSessioinsList = [AVAudioPlayer](repeating: AVAudioPlayer(), count: 24)
    
    override init() {
        super.init()
        self.loadFileList()
        self.testSound()
    }
}

//MARK: - Init the sound
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
}


//MARK: - AVAudioSessions
extension SoundManager {
    
    func testSound() { //!!!: To be removed
        
        self.playStopSoundOnSession(session: 0, sound: soundList[0][0], nuberOfLoops: -1)
        self.playStopSoundOnSession(session: 1, sound: soundList[1][1], nuberOfLoops: -1)
    }
    
    func playStopSoundOnSession(session: Int, sound: String = "", nuberOfLoops: Int = 0) {
        
        if sound.isEmpty {
            audioSessioinsList[session].stop()
        }else {
            
            do{
                try audioSessioinsList[session] = AVAudioPlayer(contentsOf: URL(fileURLWithPath:sound))
            }catch {
                print(error)
            }
            audioSessioinsList[session].numberOfLoops = nuberOfLoops
            audioSessioinsList[session].prepareToPlay()
            audioSessioinsList[session].play()
        }
    }
}
