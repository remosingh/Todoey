//
//  ViewController.swift
//  Todoey
//
//  Created by Remo Bajwa on 2018-03-02.
//  Copyright © 2018 Remo Bajwa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Mike2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Mike3"
        itemArray.append(newItem3)
    
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        itemArray = items
       }
        
        
    }

   //MARK - TabelView datasource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - how to add the contents of a cell in a table view
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none              // Ternary operator for doing if else statements in one line. value = condition ? valueIfTrue : valueIfFalse. dont even     need to put "== true" in front of item.done
        
        return cell
        
    
    }

    //MARK - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedText = itemArray[indexPath.row]
        
       // print(indexPath.row)
        print(selectedText)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            // what will happen once the user clicks on add button on a UIALert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    

}

