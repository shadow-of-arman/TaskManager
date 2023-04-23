//
//  CreateTaskView.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import SwiftUI

struct CreateTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    let action: (_ title: String, _ description: String) -> ()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        self.action(title, description)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//MARK: - Preview

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(action: { title, description in
            //
        })
    }
}
