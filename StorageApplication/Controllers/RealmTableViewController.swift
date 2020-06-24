//
//  RealmTableViewController.swift
//  StorageApplication
//
//  Created by Александр Уткин on 15.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import UIKit

class RealmTableViewController: UITableViewController {
    
    var realmDataTasks: [ModelRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realmDataTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = realmDataTasks[indexPath.row].task        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = realmDataTasks[indexPath.row]
        
        if editingStyle == .delete {
           //deleteTask(task, indexPath: indexPath)
        }
    }
        
    
    @IBAction func addTask(_ sender: Any) {
        
        let alert = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
        let newTask = ModelRealm(task: task)
        self.realmDataTasks.append(newTask)
            
            self.tableView.insertRows(at: [IndexPath(row: self.realmDataTasks.count - 1, section: 0)], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
}
