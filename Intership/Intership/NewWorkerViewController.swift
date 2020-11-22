//
//  NewWorkerViewController.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

private enum CellType: Int {
    case imageCell
    case nameCell
    case surnameCell
    case birthDayCell
    case companyCell
    case controlButtonCell
}

class NewWorkerViewController: UITableViewController {
    
    private var companyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        var baseCell = UITableViewCell()
        
        switch cellType {
        case .imageCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            baseCell = cell
            
        case .nameCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Name"
            baseCell = cell

        case .surnameCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Surname"
            baseCell = cell

        case .birthDayCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Birthday"
            baseCell = cell

        case .companyCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableViewCell", for:indexPath) as! CompanyTableViewCell
            
            cell.companyText.text = companyName ?? "Company"
            
            baseCell = cell

        case .controlButtonCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for:indexPath) as! ButtonTableViewCell
            cell.didPressControlButton = {[weak self] in
                self?.showAlert()
            }
            
            
            baseCell = cell
        }
        
        baseCell.selectionStyle = .none
        return baseCell
    }
    
    override func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return
        }
        
        if cellType == .companyCell {
            let companiesListTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "CompanyListTableViewController") as? CompanyListTableViewController
            
            companiesListTableViewController?.delegate = self
            
            self.navigationController?.pushViewController(companiesListTableViewController!, animated: true)
        }
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(
            title: "Success!",
            message: "Data was successfully saved.",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension NewWorkerViewController: CompanyListDelegate {
    func selectedCompany(companyName: String) {
        self.companyName = companyName
        self.tableView.reloadData()
    }
}
