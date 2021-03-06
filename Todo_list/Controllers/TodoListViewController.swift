//
//  ViewController.swift
//  Todo_list
//
//  Created by jigar on 19/08/20.
//  Copyright © 2020 jigar. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
 
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
      
        
       // print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//
//        let newItem2 = Item()
//        newItem2.title = "Jigar"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Ketchup"
//        itemArray.append(newItem3)
//
//

        loadItems()
        
    }
            
    
    
    
    //MARK: -  TableView Datasource Methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? . checkmark : .none
        
        

        return cell
        
    }
    
    //MARK: -  TableView Delegate Method
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   print(itemArray[indexPath.row])
        
      
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: -  Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // whatever will happen once the user clicks the add item button on our UIAlert
          
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
          
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            
            textField = alertTextField
            
         
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    
   //MARK: -  Model Manipulation Methods
    
    func saveItems(){
        
        
        do
        {
            try context.save()
        }
        catch
        {
         print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    
    func loadItems()
    {
        let request : NSFetchRequest <Item> = Item.fetchRequest()
        do{
           
            itemArray = try context.fetch(request)
            
        }
        catch {
            print("Error fetching data from context\(error)")
        }
}
}

