//
//  AddItemsVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemsVCDelegate {
    func saveItem(by: AddItemsVC, title: String, indexPath: NSIndexPath?)
}

class AddItemsVC: UIViewController {
    
    var delegate: AddItemsVCDelegate?
    var indexPath: NSIndexPath?
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {

        delegate?.saveItem(by: self, title: addItemsTextField.text!, indexPath: indexPath)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var addItemsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
