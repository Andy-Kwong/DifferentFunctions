//
//  ViewController.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import UIKit

class SwitchVC: UIViewController {

    @IBAction func Switch(_ sender: UISwitch) {
        if sender.isOn {
            switchLabel.text = "This switch is on"
        }
        else {
            switchLabel.text = "This switch is off"
        }
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toDatePickerSegue", sender: self)
    }
    
    
    @IBOutlet weak var SwitchUI: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        SwitchUI.isOn = false
        switchLabel.text = "This switch is off"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

