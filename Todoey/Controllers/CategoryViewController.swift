//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdallah Ismail on 6/2/19.
//  Copyright © 2019 Abdallah Abdelrahman. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework



class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle =  .none
        
        
    }

    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count  ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let cateogryColor = UIColor(hexString: category.color) else {fatalError()}
            
            cell.backgroundColor = cateogryColor
            
            cell.textLabel?.textColor = ContrastColorOf(cateogryColor, returnFlat: true)
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//
//        cell.textLabel?.text = categories?[indexPath.row].name  ?? "No Categories added yet"
//
//        cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color) ?? "1D9BF6")
//
//
//        return cell
//    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
        
    }
   
    
    
    
    
    //MARK: - Add New Categories

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new category"
            
        }
        
        
        present(alert,animated: true, completion: nil)
        
        
    }


    
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    
    //MARK: - Delete Methods
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryDeletedCell = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryDeletedCell)
                }
                
            } catch {
                print("Error in Deleting \(error)")
            }
            
        }
    }
    
    
    
}


