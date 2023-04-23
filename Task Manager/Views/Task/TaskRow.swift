//
//  TaskRow.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    var isCompleted: Bool {
        task.status == .done
    }
    
    var body: some View {
        HStack{
            self.information
                .opacity(self.isCompleted ? 0.25 : 1)
            Spacer()
            self.statusIndicator
        }
    }
    
    var information: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.title2)
            Text(task.description)
                .font(.body)
        }
        .foregroundColor(.primary)
    }
    
    var statusIndicator: some View {
        ZStack {
            //using image instead of Circle to support default DynamicType accessibility settings.
            Image(systemName: "circle")
                .font(.title)
            if isCompleted {
                Image(systemName: "checkmark")
                    .font(.body).bold()
            }
        }
    }
}

//MARK: - Preview

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                TaskRow(task: .init(title: "Title", description: "This is a description", status: .ongoing))
                TaskRow(task: .init(title: "Title", description: "This is a description", status: .done))
            }
        }
    }
}
