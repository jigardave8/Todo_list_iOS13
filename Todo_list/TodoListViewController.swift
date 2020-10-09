//
//  ViewController.swift
//  Todo_list
//
//  Created by jigar on 19/08/20.
//  Copyright © 2020 jigar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Jigar", "Buy Jam", " Ketup"]
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let items = defaults.stringArray(forKey: "TodoListArray"){
            itemArray = items
        }
        
        
    }
            
    
    
    
    //MARK: -  TableView Datasource Methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
        
    }
    
    //MARK: -  TableView Delegate Method
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   print(itemArray[indexPath.row])
        
        
        
        if
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: -  Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // whatever will happen once the user clicks the add item button on our UIAlert
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            
            textField = alertTextField
            
         
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}

