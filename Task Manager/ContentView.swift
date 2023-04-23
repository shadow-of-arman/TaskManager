//
//  ContentView.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var dataManager: DataManager = .init()
    
    var body: some View {
        DefaultView(dataManager: dataManager)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .inactive {
                    self.dataManager.saveTasks()
                } else if newPhase == .active {
                    self.dataManager.loadTasks()
                } else if newPhase == .background {
                    self.dataManager.saveTasks()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
