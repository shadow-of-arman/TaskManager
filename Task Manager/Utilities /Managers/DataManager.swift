//
//  DataManager.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import Foundation

class DataManager: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        self.loadTasks()
    }
    
    func loadTasks() {
        let decoder: JSONDecoder = .init()
        let defaults = UserDefaults.standard
        guard let encodedData = defaults.data(forKey: Identifiers.TASKS_DEFAULTS_KEY) else { return }
        
        do {
            self.tasks = try decoder.decode([Task].self, from: encodedData)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func saveTasks() {
        let jsonEncoder: JSONEncoder = .init()
        
        do {
            let encodedTasks = try jsonEncoder.encode(tasks)
            let defaults = UserDefaults.standard
            defaults.set(encodedTasks, forKey: Identifiers.TASKS_DEFAULTS_KEY)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func add(_ task: Task) {
        self.tasks.append(task)
        self.saveTasks()
    }
}
