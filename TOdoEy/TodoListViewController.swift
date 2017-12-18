//
//  ViewController.swift
//  TOdoEy
//
//  Created by Bartek Lanczyk on 17.12.2017.
//  Copyright © 2017 miltenkot. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    @IBOutlet var messageTableView: UITableView!
    var itemArray = ["FOund somethink", "Do somethink", "fuc evrythink"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Tableview Datasource Methods

    //simple using tableview which display content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TOdoEy item", message: "", preferredStyle: .alert)
        let acction = UIAlertAction(title: "Add Item", style: .default) { (acction) in
            //what will happen once he user clicks the dd Item button n our UIAlert
            self.itemArray.append(textField.text!)
            self.messageTableView.reloadData()
        }
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(acction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
   


}

