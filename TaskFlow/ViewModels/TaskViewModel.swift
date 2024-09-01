//
//  TaskViewModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var taskArray: [Task] = []
    
    // pendingTask array
    var pendingTask: [Task] {
        return taskArray.filter { $0.status == Status.pending.rawValue }
    }
    
    // completedTask array
    var completedTask: [Task] {
        return taskArray.filter { $0.status == Status.completed.rawValue }
    }
    
    // todayTask array
    var todayTask: [Task] {
        let today = Calendar.current.startOfDay(for: Date())
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: today)
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return taskArray.filter {
            if let createdAt = $0.createdAt, let taskDate = dateFormatter.date(from: createdAt) {
                return taskDate >= today && taskDate < endOfToday!
            }
            return false
        }
    }
    
    init() {
        fetchTasks()
    }
    
    private let base_url: String = "http://localhost:5955/api/v1/"
    
    // fetch all tasks
    func fetchTasks() {
        guard let url = URL(string: base_url + "todos/getTodo") else {
            print("Invalid URL for fetching Task")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = ["user": UserDefaults.standard.string(forKey: "userID")]
        print("\(UserDefaults.standard.string(forKey: "userID")!)")
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        // add bearer token for authentication
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in fetching task: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskResponse.self, from: data)
                    
                    if let taskData = decodedResponse.data {
                        DispatchQueue.main.async {
                            self.taskArray = taskData
                        }
                    }
                    
                } catch {
                    print("Failed to parse JSON response")
                }
            }
            
        }.resume()
        
    }
    
    func addTask (title: String, description: String, selectedStatus: Status) {
        guard let url = URL(string: base_url + "todos/addTodo") else {
            print("Invalid addTask URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataBody = ["title": title, "desc": description, "status": selectedStatus.rawValue, "user": UserDefaults.standard.string(forKey: "userID")!]
        request.httpBody = try? JSONSerialization.data(withJSONObject: dataBody, options: [])
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in adding Task: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                do {
                    let decodedResponse = try JSONDecoder().decode(addTaskResponse.self, from: data!)
                    
                    if let taskData = decodedResponse.data {
                        DispatchQueue.main.async {
                            self.taskArray.append(taskData)
                        }
                    }
                } catch {
                    print("Failed to parse JSON response")
                }
            }
        }.resume()
    }
    
    func deleteTask(id: String) {
        // Construct the URL with the task ID
        guard let url = URL(string: "\(base_url)todos/removeTodo/\(id)") else {
            print("Invalid delete URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Set the Authorization header with Bearer token
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in deleting task: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    // Remove task from the array
                    if let index = self.taskArray.firstIndex(where: { $0.id == id }) {
                        self.taskArray.remove(at: index)
                    }
                }
            } else {
                print("Failed to delete task with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        }.resume()
    }

}
