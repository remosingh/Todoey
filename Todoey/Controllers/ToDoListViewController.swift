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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Itesm.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
        
        
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
        
        self.saveItems()
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
        self.saveItems()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func saveItems () {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("errir encoding")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems () {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error")
            }
        }
    }
    
    
    
    

}

