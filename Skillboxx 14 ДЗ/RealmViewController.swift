
import UIKit
import Realm
import RealmSwift

class TasksList: Object {
    @objc dynamic var task = ""
    @objc dynamic var completed = false
}

class Garbage: Object {
    @objc dynamic var task = ""
}

class RealmViewController: UIViewController {
    
    
    
    let realm = try! Realm()
    var tasksArray = [String]()

    
    var realmTableViewCell = RealmTableViewCell()
    
    @IBOutlet var tableViewOutlet: UITableView!
    @IBOutlet var textFieldOutlet: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in realm.objects(TasksList.self) {
            tasksArray.append(i.task)
        }
        

        

    }
    
    @IBAction func addButton(_ sender: Any) {
        

        
        if textFieldOutlet.text != "" {
            
                    try! realm.write {
                        let newObject = TasksList()
                        newObject.task = textFieldOutlet.text!
                        realm.add(newObject)
                        print(newObject)
        
                    }
            
            
        tasksArray.append(textFieldOutlet.text!)
            
            textFieldOutlet.text = ""
        }
        
        tableViewOutlet.reloadData()
    }
    
    


}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell") as! RealmTableViewCell
        cell.labelOutlet.text = tasksArray[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            

            let garbage = realm.objects(TasksList.self)[indexPath.row]
            try! realm.write {
                realm.delete(garbage)
            }
            
            tasksArray.remove(at: indexPath.row)
            tableView.reloadData()

        }
    }
    
    
}
