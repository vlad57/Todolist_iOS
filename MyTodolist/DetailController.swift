//
//  ViewController.swift
//  MyTodolist
//
//  Created by Vladislav VOROBYEV on 21/12/2018.
//  Copyright © 2018 Vladislav VOROBYEV. All rights reserved.
//

import UIKit
import os.log

class DetailController: UIViewController {
    @IBOutlet weak var titleEntry: UITextField!
    @IBOutlet weak var taskEntry: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todolist: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todolist = todolist {
            titleEntry.text = todolist.title
            taskEntry.text = todolist.task
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let title = titleEntry.text
        let task = taskEntry.text
        
        todolist = Todo(Title: title!, Task: task!)
        os_log("Pressed save")
    }


}

