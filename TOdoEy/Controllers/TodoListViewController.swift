//
//  ViewController.swift
//  TOdoEy
//
//  Created by Bartek Lanczyk on 17.12.2017.
//  Copyright © 2017 miltenkot. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print("\( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))"
        )
        
        
        
        loadItems()
        
    }
    
    //MARK: - Tableview Datasource Methods

    //simple using tableview which display content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
     
    
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       
        saveItems()
        
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TOdoEy item", message: "", preferredStyle: .alert)
        let acction = UIAlertAction(title: "Add Item", style: .default) { (acction) in
            //what will happen once he user clicks the dd Item button n our UIAlert
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            self.saveItems()
            
           
        }
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(acction)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manupulation Methods
    
    func saveItems(){
        
        do{
            try context.save()
        }
        catch {
            print("Error save context, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
     

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", (selectedCategory?.name!)!)
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
        }
        do{
        itemArray = try context.fetch(request)
        }
        catch{
            print("Error fetching data from context, \(error)")
        }
        tableView.reloadData()
    }
    
   


}
extension TodoListViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
      
        loadItems(with: request)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
        }
    }

    
}

