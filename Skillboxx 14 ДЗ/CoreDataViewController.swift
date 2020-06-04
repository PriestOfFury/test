//
//  CoreDataViewController.swift
//  Skillbox 14 ДЗ
//
//  Created by Алёша on 25.05.2020.
//  Copyright © 2020 Алёша. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UITableViewController {
    
    var items = [NSManagedObject]()
    let cellId = "cellId"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить задачу", style: .plain, target: self, action: #selector(addItem))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        do {
            items = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Не удалось получить данные", err)
        }
        
        
        
    }
    
    
    @objc func addItem(_ sender: AnyObject) {
        print("Added")
        let alertController = UIAlertController(title: "Добавить задачу", message: "Заполните данное поле", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let itemToAdd = textField.text else { return }
            self.save(itemToAdd)
            self.tableView.reloadData()
            
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func save(_ itemName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "ItemName")
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let err as NSError {
            print("Failed to save an item", err)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.value(forKeyPath: "itemName") as? String
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let currentItem = items[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext

                managedContext.delete(currentItem)
                items.remove(at: indexPath.row)
            
            do {
                try managedContext.save()
            } catch let err {
                print("Ошибочка где-то в удалении элемента", err)
            }


            tableView.reloadData()
        }
    }
    

}
