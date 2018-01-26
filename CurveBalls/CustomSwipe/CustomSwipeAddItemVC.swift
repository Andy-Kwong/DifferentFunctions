//
//  CustomSwipeAddItemVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import UIKit

protocol addTaskDelegate : class {
    func saveItem(by: CustomSwipeAddItemVC, title: String, date: Date, description: String, indexPath: NSIndexPath?)
}

class CustomSwipeAddItemVC: UIViewController , UITextFieldDelegate {

    var delegate: addTaskDelegate?
    var indexPath: NSIndexPath?

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var datePickerField: UIDatePicker!
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let submitTitle = titleLabel.text
        let submitDate = datePickerField.date
        let submitDesc = descriptionLabel.text
        delegate?.saveItem(by: self, title: submitTitle!, date: submitDate, description: submitDesc!, indexPath: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.delegate = self
        descriptionLabel.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleLabel.resignFirstResponder()
        descriptionLabel.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
