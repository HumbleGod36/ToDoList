//
//  AddViewController.swift
//  ToDoList
//
//  Created by Tony Michael on 12/01/24.
//

import UIKit

protocol dataTransferingMainController {
    func didAddTask(toDoItem: ToDoItemModel)
    
}


class AddViewController: UIViewController , UITextFieldDelegate {
    
    var formatter : DateFormatter {
       let localFormatter = DateFormatter()
       localFormatter.dateFormat = "yyyy-MM-dd"
       return localFormatter
    }
    
    var timeFormatter : DateFormatter {
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = "HH:mm"
        return localFormatter
    }
    
    var delegate : dataTransferingMainController?
    var selectedDate : String = ""
    var  selectedTime : String = ""

    @objc func dateChanged(_ sender: UIDatePicker) {
      
            selectedDate = formatter.string(from: sender.date)
            selectedTime = timeFormatter.string(from: sender.date)
        
    }
    @IBOutlet weak var timePicked: UIDatePicker!
    @IBOutlet weak var taskField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = formatter.string(from: Date())
        selectedTime = timeFormatter.string(from: Date())
        taskField.becomeFirstResponder()
        
        timePicked.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        delegate?.didAddTask(toDoItem: ToDoItemModel.init(taskLabel: taskField.text ?? "", isCompleted: false, date: selectedDate, time: selectedTime))
        self.dismiss(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskField.resignFirstResponder()
    }
}


