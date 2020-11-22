//
//  CompanyListTableViewController.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

protocol CompanyListDelegate: class {
    func selectedCompany (companyName: String)
}

class CompanyListTableViewController: UITableViewController {
    
    let companies = ["Apple", "Google", "IBM","Tesla", "Microsoft"]
    
    weak var delegate: CompanyListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return companies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableViewCell", for: indexPath) as! CompanyTableViewCell
        
        cell.companyText.text = companies[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCompany = companies[indexPath.row]
        delegate?.selectedCompany(companyName: selectedCompany)
        self.navigationController?.popViewController(animated: true)
    }
}
