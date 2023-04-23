//
//  DefaultView.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import SwiftUI

struct DefaultView: View {
    @ObservedObject var dataManager: DataManager
    @State private var presentSheet: Bool = false
    @State private var filterActive: Bool = false
    
    private var completedTasks: [Task] {
        self.dataManager.tasks.filter { $0.status == .done }
    
    }
    
    private var remainingTasks: [Task] {
        self.dataManager.tasks.filter { $0.status == .ongoing }
            
    }
    
    private var orderedTasks: [Task] {
        self.dataManager.tasks
    }
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                if dataManager.tasks.isEmpty {
                    Text("No tasks found, add a new one using the plus button")
                } else {
                    self.taskList
                }
            }
            .animation(.easeInOut, value: self.filterActive)
            .navigationTitle("Arman Zoghi")
            .toolbar {
                self.toolbarContent
            }
        }
        .sheet(isPresented: $presentSheet) {
            CreateTaskView { title, description in
                let task = Task(title: title, description: description, status: .ongoing)
                self.dataManager.add(task)
            }
        }
    }

    //MARK: - Lists and Sections
    
    var taskList: some View {
        List {
            Toggle("Filter tasks", isOn: $filterActive)
            if filterActive {
                self.filteredList
            } else {
                self.normalList
            }
        }
        .listStyle(.insetGrouped)
    }
    
    var filteredList: some View {
        Group {
            remainingSection
            completedSection
        }
    }
    
    var remainingSection: some View {
        Section {
            let tasks = self.remainingTasks //calculate once
            if tasks.isEmpty {
                Text("All done!")
            } else {
                ForEach(tasks) { task in
                    row(for: task)
                }
                .onMove { indexSet, index in
                    self.dataManager.tasks.move(fromOffsets: indexSet, toOffset: index)
                }
            }
        } header: {
            Text("Remaining")
                .foregroundColor(.red)
        }
    }
    
    var completedSection: some View {
        Section {
            let tasks = self.completedTasks
            if tasks.isEmpty {
                Text("No tasks completed yet.")
            } else {
                ForEach(tasks) { task in
                    row(for: task)
                }
                .onMove { indexSet, index in
                    self.dataManager.tasks.move(fromOffsets: indexSet, toOffset: index)
                }
            }
        } header: {
            Text("Completed")
                .foregroundColor(.green)
        }
    }
    
    var normalList: some View {
        Section {
            ForEach(self.dataManager.tasks) { task in
                row(for: task)
            }
            .onMove { indexSet, index in
                self.dataManager.tasks.move(fromOffsets: indexSet, toOffset: index)
            }
        } header: {
            Text("Tasks")
        }
    }
    
    func row(for task: Task) -> some View {
        Button {
            withAnimation {
                self.dataManager.objectWillChange.send()
                task.toggle()
            }
        } label: {
            TaskRow(task: task)
                .id(task.id.uuidString + task.status.rawValue)
        }
    }
    
    //MARK: - Toolbar
    
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                presentSheet = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

//MARK: - Preview

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView(dataManager: .init())
    }
}
