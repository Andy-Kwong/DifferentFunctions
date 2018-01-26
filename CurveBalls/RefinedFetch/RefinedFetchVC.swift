//
//  RefinedFetchVC.swift
//  CurveBalls
//
//  Created by Andy Kwong on 1/25/18.
//  Copyright © 2018 Andy Kwong. All rights reserved.
//

import UIKit
import CoreData

class RefinedFetchVC: UIViewController {
    
    var animals = [Animals]()
    var allAnimals = [Animals]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if allAnimals.count < 1 {
            populateDatabase()
        }
        fetchAll("all")
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func populateDatabase() {
        let populate = [["Chameleon", "Reptile"], ["Crocodile", "Reptile"], ["Dolphin", "Mammal"], ["Fox", "Mammal"], ["Hawksbill Turtle", "Reptile"]]
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Animals", into: managedObjectContext) as! Animals
        
        for animal in populate {
            item.name = animal[0]
            item.type = animal[1]
            allAnimals.append(item)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func showAllAnimals(_ sender: UIButton) {
        fetchAll("all")
        tableView.reloadData()
    }
    
    @IBAction func showOnlyReptiles(_ sender: UIButton) {
        fetchAll("Reptile")
        tableView.reloadData()
    }
    
    @IBAction func showOnlyMammals(_ sender: UIButton) {
        fetchAll("Mammal")
        tableView.reloadData()
    }
    
    
    func fetchAll(_ allReptilesOrMammals: String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animals")
        
        if allReptilesOrMammals == "Reptile" || allReptilesOrMammals == "Mammal" {
            print("hello")
            request.predicate = NSPredicate(format: "type == %@", allReptilesOrMammals)
            
            do {
                let result = try managedObjectContext.fetch(request)
                animals = result as! [Animals]
            } catch {
                print(error)
            }
            
        }
            
//        else if allReptilesOrMammals == "Mammal"{
//
//            request.predicate = NSPredicate(format: "type == %@", allReptilesOrMammals)
//
//            do {
//                let result = try managedObjectContext.fetch(request)
//                animals = result as! [Animals]
//            } catch {
//                print(error)
//            }
//        }
            
        else {
            print("goodbye")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animals")
            
            do {
                let result = try managedObjectContext.fetch(request)
                animals = result as! [Animals]
            } catch {
                print(error)
            }
        }
        

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

extension RefinedFetchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Woohoo!")
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
        
        let animal = animals[indexPath.row]
        
        cell.textLabel?.text = animal.name
        
        return cell
    }
    
    
    
}
