//
//  SoundPadCell.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 8/23/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import UIKit

class SoundPadCell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet var playStopButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBAction func playStopButtonPressed(_ sender: AnyObject) {
        print("func\(#function)")
    }
    
    @IBAction func secondButtonPressed(_ sender: AnyObject) {
        print("func\(#function)")
    }

    @IBAction func volumeSliderValueChanged(_ sender: AnyObject) {
        print("func\(#function)")
    }
    
  }
