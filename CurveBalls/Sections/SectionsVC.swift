//
//  SectionsVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SectionsVC: UIViewController, AddItemsVCDelegate {
    
    var data = [SectionsData]()
    
    let sections = ["Complete", "Incomplete"]
    var incomplete = [SectionsData]()
    var complete = [SectionsData()]
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var sectionsTableView: UITableView!
    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "sectionAddItemSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllData()
        
        sectionsTableView.dataSource = self
        sectionsTableView.delegate = self
    }
    
    func fetchAllData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SectionsData")
        
        do {
            request.predicate = NSPredicate(format: "completed == %@", NSNumber(value:false))
            incomplete = try managedObjectContext.fetch(request) as! [SectionsData]
            request.predicate = NSPredicate(format: "completed == %@", NSNumber(value: true))
            complete = try managedObjectContext.fetch(request) as! [SectionsData]
        } catch {
            print(error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addItemsVC = segue.destination as! AddItemsVC
        addItemsVC.delegate = self
        
    }
    
    func saveItem(by: AddItemsVC, title: String, indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = data[ip.row]
            item.title = title
        }
        
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "SectionsData", into: managedObjectContext) as! SectionsData
            
            item.completed = false
            item.title = title
            incomplete.append(item)
        }
        
        do {
            try managedObjectContext.save()
        }
        catch {
            print(error)
        }
        
        sectionsTableView.reloadData()
    }
    
}

extension SectionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numOfRows = [incomplete.count, complete.count]
        
        return numOfRows[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        
        if indexPath.section == 0 {
            if incomplete.count > 0 {
                let text = incomplete[indexPath.row].title
                cell.textLabel?.text = text
            }
        }
        else {
            if complete.count > 0 {
                let text = complete[indexPath.row].title
                cell.textLabel?.text = text
            }
            
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let incompleteTask = incomplete[indexPath.row]
            incompleteTask.completed = true
        }
        else if indexPath.section == 1 {
            let completedTask = complete[indexPath.row]
            completedTask.completed = false
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        fetchAllData()
        sectionsTableView.reloadData()
        
    }
    
    
}
