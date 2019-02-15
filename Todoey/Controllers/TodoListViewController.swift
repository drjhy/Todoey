//
//  ViewController.swift
//  Todoey
//
//  Created by John Young on 2/3/19.
//  Copyright © 2019 John Young. All rights reserved.
//

import UIKit
import RealmSwift



class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    
    var todoItems: Results<Item>?
    
    var selectedCategory : Category?{
        
        didSet{
            
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    }


    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        //value  =  condition ?  valueIfTrue: valueIfFalse
        
        cell.accessoryType =  item.done ? .checkmark  : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added..."
            
        }
        
        return cell
    }
    // MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems? [indexPath.row] {
            
            do {
                try realm.write {
                    item.done = !item.done
                }
                
            } catch {
                print("Error saving done status, \(error)")
            }
            
        }
       
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
//MARK -- ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let  action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            if let currentCategory = self.selectedCategory {
        
            do {
                try self.realm.write {
                    
                    let  newItem  = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                }
            } catch {
                print("Error saving context \(error)")
            }
          self.tableView.reloadData()
        }
        
        }
            
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField  = alertTextField
        }
          
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    
        
    }
   
        func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        }

    }


// MARK -- Search bar methods

//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//
//        }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            // loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//   }
//


    
    




