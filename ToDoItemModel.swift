// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let menuModel = try? JSONDecoder().decode(MenuModel.self, from: jsonData)

import Foundation

// MARK: - MenuModelElement
class ToDoItemModel: Codable {
    let taskLabel: String
    var isCompleted: Bool
    let date: String
    let time: String

    enum CodingKeys: String, CodingKey {
        case taskLabel = "task_label"
        case isCompleted = "is_completed"
        case date
        case time
    }

    init(taskLabel: String, isCompleted: Bool, date: String , time : String) {
        self.taskLabel = taskLabel
        self.isCompleted = isCompleted
        self.date = date
        self.time = time
    }
}

typealias ToDoList = [ToDoItemModel]
