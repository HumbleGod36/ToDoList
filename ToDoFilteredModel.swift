//
//  ToDoFilteredModelClass.swift
//  ToDoList
//
//  Created by Tony Michael on 13/01/24.
//

import Foundation

class ToDoFilteredModel{
    let date : String
    let items : [ToDoItemModel]
    
    init(date: String, items: [ToDoItemModel]) {
        self.date = date
        self.items = items
    }
}
