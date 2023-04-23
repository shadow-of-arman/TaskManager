//
//  Task.swift
//  Task Manager
//
//  Created by Arman Zoghi on 4/23/23.
//

import Foundation

class Task: Codable, Hashable, Identifiable, ObservableObject {
    let id: UUID
    let title: String
    let description: String
    @Published var status: TaskStatus //using enum instead of bool to future proof different states
    
    //Custom init so we can assign an auto ID upon creation, without getting warning cause of codable (reduce warnings in project)
    internal init(title: String, description: String, status: TaskStatus = .ongoing) {
        self.id = .init()
        self.title = title
        self.description = description
        self.status = status
    }
    
    enum CodingKeys: CodingKey {
        case id, title, description, status, orderNumber
    }
    
    //Have to manually encode and decode, because @Published messes with Codable auto systems
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.status, forKey: .status)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try container!.decodeIfPresent(UUID.self, forKey: .id)!
        self.title = try container!.decodeIfPresent(String.self, forKey: .title)!
        self.description = try container!.decodeIfPresent(String.self, forKey: .description)!
        self.status = try container!.decodeIfPresent(TaskStatus.self, forKey: .status)!
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
    
     func toggle() {
        switch status {
        case .done:
            self.status = .ongoing
        case .ongoing:
            self.status = .done
        }
    }
}
