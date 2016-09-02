//
//  SoundFlow.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/24/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import AVFoundation

protocol SoundFlowDelegate: class {
    
    func didStopAudioSession(_ sender: SoundFlow)
}


class SoundFlow: NSObject {
    
    var baseItem: SoundPadItem
    let audioSession: AVAudioPlayer
    weak var delegate: SoundFlowDelegate?
    
    init(baseItem: SoundPadItem) {
        
        self.baseItem = baseItem
        do {
            let splitAddress = baseItem.fileAddress.components(separatedBy: "TableTop Ambience.app")
            
            let newAdress = Bundle.main.bundlePath + splitAddress[1]
            
            try self.audioSession = AVAudioPlayer(contentsOf: URL(fileURLWithPath: newAdress))
            audioSession.volume = baseItem.volume
        } catch {
            
            print(error)
            self.audioSession = AVAudioPlayer()
        }
    }
}

extension SoundFlow: SoundPadCellDelegate {
    
    func playStopButtonPressed(_ sender: AnyObject) {
        
        audioSession.delegate = self
        
        if audioSession.isPlaying {
            
            audioSession.stop()
        } else {
            
            audioSession.play()
        }
    }
    
    func repeatButtonPressed(_ sender: AnyObject) { //FIXME: if autorepeat is turned off while the file is playing, it won't stop
        
        if baseItem.autoRepeat {
            
            audioSession.numberOfLoops = 1
        } else {
            
            baseItem = baseItem.setAutoRepeat(autoRepeat: true)
            audioSession.numberOfLoops = -666 //any negative will do
        }
        
        baseItem = baseItem.setAutoRepeat(autoRepeat: !baseItem.autoRepeat)
    }
    
    func volumeSliderValueChanged(_ sender: AnyObject) {
        
        audioSession.volume = sender.value
        baseItem = baseItem.setVolume(volume: audioSession.volume)
    }
}

extension SoundFlow: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        delegate?.didStopAudioSession(self)
    }
}
