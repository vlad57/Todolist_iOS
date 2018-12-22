//
//  TodoTableViewController.swift
//  MyTodolist
//
//  Created by Vladislav VOROBYEV on 21/12/2018.
//  Copyright © 2018 Vladislav VOROBYEV. All rights reserved.
//

import UIKit
import os.log

class TodoTableViewController: UITableViewController {
    
//    Properties
    
    var todoLit = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadTodoList = loadTodo() {
            todoLit += loadTodoList
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoLit.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "TodoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let todo = todoLit[indexPath.row]

        cell.titleLabel.text = todo.title
        cell.taskLabel.text = todo.task
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
 }*/
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoLit.remove(at: indexPath.row)
            saveTodo()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case "AddTask":
            os_log("Press add item")
        case "EditTask":
            guard let todoDetailController = segue.destination as? DetailController else {
                fatalError("Ce controller n'existe pas")
            }
            guard let selectTodoCell = sender as? TodoTableViewCell else {
                fatalError("Cette cellule n'existe pas")
            }
            guard let indexPath = tableView.indexPath(for: selectTodoCell) else {
                fatalError("Cet index n'existe pas")
            }
            
            let selectedTodo = todoLit[indexPath.row]
            todoDetailController.todolist = selectedTodo
            
        default:
            os_log("Default")
        }
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
       // let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        if let sourceViewController = sender.source as? DetailController, let todo = sourceViewController.todolist {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todoLit[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: todoLit.count, section: 0)
                todoLit.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveTodo()
        }
    }
    
    private func saveTodo(){
        let isSaveSuccessful = NSKeyedArchiver.archiveRootObject(todoLit, toFile: Todo.ArchiveURL.path)
        
        if isSaveSuccessful{
            os_log("Save successful")
        } else {
            os_log("Save failed")
        }
    }
    
    private func loadTodo() -> [Todo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
    }
 

}
