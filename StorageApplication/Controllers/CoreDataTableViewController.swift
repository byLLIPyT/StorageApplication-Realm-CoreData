//
//  CoreDataTableViewController.swift
//  StorageApplication
//
//  Created by Александр Уткин on 15.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {
    
    var coreDataTasks: [Task] = []
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coreDataTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = coreDataTasks[indexPath.row].task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let task = coreDataTasks[indexPath.row]
        if editingStyle == .delete {
            deleteTask(task, indexPath: indexPath)
        }
    }
    
    private func deleteTask(_ task: Task, indexPath: IndexPath) {
        manageContext.delete(task)
        do {
            try manageContext.save()
            coreDataTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        let alert = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.save(task)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    private func save(_ taskName: String) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: manageContext) else { return }
        let task = NSManagedObject(entity: entityDescription, insertInto: manageContext) as! Task
        task.task = taskName
        
        do {
            try manageContext.save()
            coreDataTasks.append(task)
            self.tableView.insertRows(at: [IndexPath(row: self.coreDataTasks.count - 1, section: 0)], with: .automatic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            coreDataTasks = try manageContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
    }
}
