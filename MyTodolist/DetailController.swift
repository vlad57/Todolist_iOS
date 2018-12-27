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
    @IBOutlet weak var dateTextEntry: UITextField!
    
    var todolist: Todo?
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        
        if let todolist = todolist {
            titleEntry.text = todolist.title
            taskEntry.text = todolist.task
            dateTextEntry.text = todolist.date
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
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTextEntry.inputAccessoryView = toolbar
        dateTextEntry.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextEntry.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let title = titleEntry.text
        let task = taskEntry.text
        let date = dateTextEntry.text
        
        todolist = Todo(Title: title!, Task: task!, Date: date!)
        os_log("Pressed save")
    }


}

