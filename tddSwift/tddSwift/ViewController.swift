//
//  ViewController.swift
//  tddSwift
//
//  Created by Carl Udren on 10/9/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var makeMathHappenSwitch: UISwitch!
    @IBOutlet var meaningOfLifeSwitch: UISwitch!
    @IBOutlet var resultLabel: UILabel!
    
    var mathHelper = MathHelper()
    var mathArray: Array<Float> = [7.8, 5.0, 3.4, 12.2]
    
    @IBAction func makeMathHappenSwitchChangedValue(_ sender: UISwitch) {
        if sender.isOn, meaningOfLifeSwitch.isOn{
            self.resultLabel.text = "42"
            return
        }
        resultLabel.text = sender.isOn ? String(mathHelper.sumArray(array: mathArray)) : mathHelper.doNoMath()
    }
    
    @IBAction func meaningOfLifeSwitchChangedValue(_ sender: UISwitch) {
        if !makeMathHappenSwitch.isOn { return }
        
        if sender.isOn {
            mathArray.append(42.0)
        } else {
            if let indexOf42 = mathArray.index(of: 42) {
                mathArray.remove(at: indexOf42)
            }
        }
        resultLabel.text = String(mathHelper.sumArray(array: mathArray))
    }
}

