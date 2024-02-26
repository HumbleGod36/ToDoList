//
//  ViewController.swift
//  ToDoList
//
//  Created by Tony Michael on 12/01/24.
//

import UIKit


class ViewController: UIViewController , dataTransferingMainController {
    func didAddTask(toDoItem: ToDoItemModel) {
        toDoList.append(toDoItem)
        filterData()
    }
    
  
    var formatter : DateFormatter {
       let localFormatter = DateFormatter()
       localFormatter.dateFormat = "yyyy-MM-dd"
       return localFormatter
    }
    
    
    
   var filteredToDolist = [ToDoFilteredModel]()
    
    var toDoList = [ToDoItemModel]()
    
    @IBOutlet weak var eniterTable: UITableView!
   // var data : [String] = [ "tony", "Gous" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eniterTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        eniterTable.register(UINib(nibName: "HeaderViewCell", bundle: nil),forHeaderFooterViewReuseIdentifier: "HeaderViewCell")
        eniterTable.delegate = self
        eniterTable.dataSource = self
        fetchData()
  
        
    }
    func fetchData() {
        if let path = Bundle.main.path(forResource: "DummyData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),options: .mappedIfSafe)
                do{
                    let menu = try JSONDecoder().decode([ToDoItemModel].self, from: data)
                    print(menu)
                    self.toDoList = menu
                    filterData()
                }catch {
                    print(error)
                }
                
            }catch {
                print (error)
            }
        }
    }
    
    func filterData() {
        
      let groupedData =   Dictionary(grouping: self.toDoList, by: { $0.date })
        var filteredList = [ToDoFilteredModel]()
        for i in groupedData{
            filteredList.append(ToDoFilteredModel.init(date: i.key, items: i.value))
        }
        
        self.filteredToDolist = filteredList.sorted { $0.date < $1.date }
       print(filteredList)
        eniterTable.reloadData()
    }
   
    

}
extension ViewController : UITableViewDelegate{
    
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredToDolist[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.doneButton.layer.borderWidth = 1
        cell.doneButton.layer.borderColor = UIColor(named: "black")?.cgColor
        cell.doneButton.addTarget(self, action: #selector(self.cellButtonClicked(_:)), for: .touchUpInside)
        cell.taskLabel.text = filteredToDolist[indexPath.section].items[indexPath.row].taskLabel
        cell.doneButton.tag = indexPath.row
       // cell.doneButton.backgroundColor = .orange
        cell.timeLabel.text = filteredToDolist[indexPath.section].items[indexPath.row].time
        
    
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredToDolist.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewCell") as! HeaderViewCell
        
        if filteredToDolist[section].date == formatter.string(from: Date()) {
            cell.headerLabel.text = "Today"
           
        } else if filteredToDolist[section].date == formatter.string(from: Date().dayAfter) {
            cell.headerLabel.text = "Tomorrow"
        } else {
            cell.headerLabel.text = filteredToDolist[section].date
             
        }
      
        
          
        
        
        cell.addButton.addTarget(self, action: #selector(self.addButtonClicked(_:)), for: .touchUpInside)
       
        return cell
    }
    @objc func addButtonClicked (_ sender : UIButton) {
        let Vc1 = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        Vc1.modalPresentationStyle = .fullScreen
        self.present(Vc1, animated: true)
        Vc1.delegate = self
        
    }
    
   
    
    @objc func cellButtonClicked (_ sender : UIButton){
      
        if(filteredToDolist[sender.tag].items[sender.tag].isCompleted == false)
        {
            sender.backgroundColor = .orange
            filteredToDolist[sender.tag].items[sender.tag].isCompleted.toggle()
        } else if (filteredToDolist[sender.tag].items[sender.tag].isCompleted == true) {
            sender.backgroundColor = .clear
            filteredToDolist[sender.tag].items[sender.tag].isCompleted.toggle()
            
        }
    }
    
    
}
extension Date {
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}

