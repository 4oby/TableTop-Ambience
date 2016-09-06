//
//  DiceRollViewController.swift
//  TableTop Ambience
//
//  Created by Victor Cebanu on 9/6/16.
//  Copyright © 2016 Victor Cebanu. All rights reserved.
//

import Foundation
import UIKit

final class DiceRollViewController: UIViewController {

    @IBOutlet weak var resultBar: UITextField!
    
    @IBAction func rollD20(_ sender: AnyObject) {
        let diceRoll = Int(arc4random_uniform(20) + 1)
        resultBar.text = String(diceRoll)
    }
}
