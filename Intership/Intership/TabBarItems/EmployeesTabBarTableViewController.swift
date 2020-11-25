//
//  EmployeesTabBarTableViewController.swift
//  Intership
//
//  Created by Елена Кириленко on 25.11.2020.
//

import UIKit
import CoreData

class EmployeesTabBarTableViewController: UITableViewController {
    
    var workers: [WorkerEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkerEntity")
        guard let workers = try? appDelegate.persistentContainer.viewContext.fetch(request) as? [WorkerEntity] else { return }
        self.workers = workers
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let newWorkerViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewWorkerViewController") as? NewWorkerViewController
        
        self.navigationController?.pushViewController(newWorkerViewController!, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTabBarCell", for: indexPath)

        let worker = workers[indexPath.row]
        
        let name = worker.name ?? "Unknown"
        let surname = worker.second_name ?? "Unknown"
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Name: \(name), Surname: \(surname)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let worker = workers[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(identifier: "NewWorkerViewController") as! NewWorkerViewController
        vc.workerToShow = worker
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
