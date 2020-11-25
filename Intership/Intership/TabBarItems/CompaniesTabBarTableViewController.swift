//
//  CompaniesTabBarTableViewController.swift
//  Intership
//
//  Created by Елена Кириленко on 25.11.2020.
//

import UIKit

class CompaniesTabBarTableViewController: UITableViewController {

    var companies = ["Apple", "Google", "IBM","Tesla", "Microsoft"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(
            title: "Add new company",
            message: nil,
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Company name"
        }
        
        alert.addAction(UIAlertAction(
                            title: "Cancel",
                            style: .cancel,
                            handler: nil))
        
        alert.addAction(UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: { [weak alert] (_) in
                                let textField = (alert?.textFields![0])! as UITextField
                                if textField.text != nil{
                                    self.companies.append(textField.text!)
                                    self.tableView.reloadData()
                                }
                            }))
        
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesTabBarCell", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
