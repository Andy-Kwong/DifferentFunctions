//
//  CustomSwipeVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import UIKit
import CoreData

class CustomSwipeVC: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var data = [CustomSwipeData]()

    @IBOutlet weak var customSwipeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        
        customSwipeTable.dataSource = self
        customSwipeTable.delegate = self

    }
    
    @IBAction func addDataButtonPressed(_ sender: UIButton) {
        
    }
    
    func fetchAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomSwipeData")
        do {
            let result = try managedObjectContext.fetch(request)
            data = result as! [CustomSwipeData]
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as? UIButton != nil {
            let addTask = segue.destination as! CustomSwipeAddItemVC
            addTask.delegate = self
        }
    }
    
    

}

extension CustomSwipeVC: UITableViewDataSource, UITableViewDelegate, addTaskDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSwipeCell", for: indexPath)
        
        // Configure the cell...
        let item = data[indexPath.row]
        cell.textLabel?.text = item.title
        
        if item.selected == "date" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            cell.detailTextLabel?.text = dateFormatter.string(from: item.date!)
        }
        else if item.selected == "desc" {
            cell.detailTextLabel?.text = item.desc
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func saveItem(by: CustomSwipeAddItemVC, title: String, date: Date, description: String, indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = data[ip.row]
            item.title = title
            item.date = date
            item.desc = description
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "CustomSwipeData", into: managedObjectContext) as! CustomSwipeData
            item.title = title
            item.desc = description
            item.date = date
            data.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        dismiss(animated: true, completion: nil)
        customSwipeTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let clear = UITableViewRowAction(style: .normal, title: "Clear") { (action, indexPath) in
            let item = self.data[indexPath.row]
            item.selected = "none"
            self.customSwipeTable.reloadRows(at: [indexPath], with: .fade)
        }
        
        let showDesc = UITableViewRowAction(style: .destructive, title: "Show Desc") { (action, indexPath) in
            let item = self.data[indexPath.row]
            item.selected = "desc"
            self.customSwipeTable.reloadRows(at: [indexPath], with: .fade)
        }
        
        let showDate = UITableViewRowAction(style: .destructive, title: "Show Date") { (action, indexPath) in
            let item = self.data[indexPath.row]
            item.selected = "date"
            self.customSwipeTable.reloadRows(at: [indexPath], with: .fade)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        let item = data[indexPath.row]
        if let selected = item.selected {
            switch selected {
            case "date":
                return [clear, showDesc]
            case "desc":
                return [clear, showDate]
            default:
                return [showDate, showDesc]
            }
        }
        
        return[showDesc, showDate]
    }
    
}
