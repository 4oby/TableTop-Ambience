//
//  SoundPadCell.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/23/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit
protocol SoundPadCellDelegate: class {
    
    func playStopButtonPressed(_ sender: AnyObject)
    func repeatButtonPressed(_ sender: AnyObject)
    func volumeSliderValueChanged(_ sender: AnyObject)
}


class SoundPadCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: SoundPadCellDelegate?
    
    @IBAction func playStopButtonPressed(_ sender: AnyObject) {
        
        if playStopButton.backgroundImage(for: .normal) == #imageLiteral(resourceName: "Play-96") {
            
            playStopButton.setBackgroundImage(#imageLiteral(resourceName: "Stop-96"), for: .normal)
        }else {
            
            playStopButton.setBackgroundImage(#imageLiteral(resourceName: "Play-96"), for: .normal)
        }
        
        delegate?.playStopButtonPressed(sender)
    }
    
    @IBAction func repeatButtonPressed(_ sender: AnyObject) {
        
        if repeatButton.backgroundImage(for: .normal) == #imageLiteral(resourceName: "Repeat-96") {
            
            repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96-highlight"), for: .normal)
        }else {
            
            repeatButton.setBackgroundImage(#imageLiteral(resourceName: "Repeat-96"), for: .normal)
        }
        
        delegate?.repeatButtonPressed(sender)
    }
    
    @IBAction func volumeSliderValueChanged(_ sender: AnyObject) {
        
        delegate?.volumeSliderValueChanged(sender)
    }
}

extension SoundPadCell: SoundFlowDelegate{
    
    func didStopAudioSession(_ sender: SoundFlow) {
        
        playStopButton.setBackgroundImage(#imageLiteral(resourceName: "Play-96"), for: .normal)
    }
}
