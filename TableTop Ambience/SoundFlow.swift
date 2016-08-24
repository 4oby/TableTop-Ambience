//
//  SoundFlow.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/24/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import AVFoundation


class SoundFlow: NSObject {
    let baseItem: SoundPadItem
    let audioSession: AVAudioPlayer
    
    init(baseItem: SoundPadItem) {
        self.baseItem = baseItem
        do{
            try self.audioSession = AVAudioPlayer(contentsOf: URL(fileURLWithPath:baseItem.fileAddress))
            audioSession.volume = baseItem.volume
        }catch {
            print(error)
            self.audioSession = AVAudioPlayer()
        }
        
    }
}

extension SoundFlow: SoundPadCellDelegate {
    
    func playStopButtonPressed(_ sender: AnyObject){
    //    print("func\(#function)")
       // print(sender)
        
        if audioSession.isPlaying {
            audioSession.stop()
        }else {
            audioSession.play()
        }
    }
    
    func repeatButtonPressed(_ sender: AnyObject){ //FIXME: if autorepeat is turned off while the file is playing, it won't stop
        if baseItem.autoRepeat {

          //  baseItem.autoRepeat = false //reinit whole thing with new baseItem
            audioSession.numberOfLoops = 1
        }else {
            //reverse baseItem.autoRepeat
            audioSession.numberOfLoops = -666 //any negative will do
        }
    }
    
    func volumeSliderValueChanged(_ sender: AnyObject){
       // print("func\(#function)")
       // print(sender)
        audioSession.volume = sender.value
    }
}
