//
//  Todo.swift
//  MyTodolist
//
//  Created by Vladislav VOROBYEV on 22/12/2018.
//  Copyright © 2018 Vladislav VOROBYEV. All rights reserved.
//

import UIKit
import os.log

class Todo: NSObject, NSCoding {
    
    var title: String
    var task: String
    var date: String
    
    struct propertyKey{
        static let title = "title"
        static let task = "task"
        static let date = "date"
    }
    
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("Todo")
    
    init(Title: String, Task: String, Date: String){
        self.title = Title
        self.task = Task
        self.date = Date
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: propertyKey.title)
        aCoder.encode(task, forKey: propertyKey.task)
        aCoder.encode(date, forKey: propertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: propertyKey.title) as? String else {
            os_log("Unable to decode the title for a Todo object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let task = aDecoder.decodeObject(forKey: propertyKey.task) as? String else {
            os_log("Unable to decode the task for a Todo object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let date = aDecoder.decodeObject(forKey: propertyKey.date) as? String else {
            os_log("Unable to decode the date for a Todo object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(Title: title, Task: task, Date: date)
    }
    
}
