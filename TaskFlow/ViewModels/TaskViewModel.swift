//
//  TaskViewModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var taskArray: [Task] = []
    
    init() {
        fetchTasks()
    }
    
    // fetch all tasks
    func fetchTasks() {
        let Task1 = Task(title: "Task 1", desc: "Description for Task 1", status: .pending)
        let Task2 = Task(title: "Task 2", desc: "Description for Task 2", status: .inProgress)
        let Task3 = Task(title: "Task 3", desc: "Description for Task 3", status: .completed)
        
        DispatchQueue.main.async {
            self.taskArray.append(contentsOf: [Task1, Task2, Task3])
        }
    }
    
    
    
}
