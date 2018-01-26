//
//  DatePickerVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    @IBAction func datePickerField(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .short
        firstLabel.text = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateStyle = .medium
        secondLabel.text = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateStyle = .long
        thirdLabel.text = dateFormatter.string(from: sender.date)
        
    }
    @IBOutlet weak var datePickerUI: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerUI.datePickerMode = UIDatePickerMode.date
        
        dateFormatter.dateStyle = .short
        firstLabel.text = dateFormatter.string(from: datePickerUI.date)
        
        dateFormatter.dateStyle = .medium
        secondLabel.text = dateFormatter.string(from: datePickerUI.date)
        
        dateFormatter.dateStyle = .long
        thirdLabel.text = dateFormatter.string(from: datePickerUI.date)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
