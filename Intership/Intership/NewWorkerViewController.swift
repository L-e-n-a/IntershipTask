//
//  NewWorkerViewController.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit
import CoreData

private enum CellType: Int {
    case imageCell
    case nameCell
    case surnameCell
    case birthDayCell
    case companyCell
    case controlButtonCell
}

class NewWorkerViewController: UITableViewController {
    
    public var workerToShow: WorkerEntity?
    
    private var imageURL: URL?
    private var name: String?
    private var surname: String?
    private var birthday: String?
    private var companyName: String?
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let worker = workerToShow {
            navigationItem.title = "\(worker.name ?? "") \(worker.second_name ?? "")"
        }
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workerToShow == nil ? 6 : 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        var baseCell = UITableViewCell()
        
        switch cellType {
        case .imageCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.loadImage(url: workerToShow?.image)
            baseCell = cell
            
        case .nameCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = workerToShow?.name
            cell.textField.placeholder = "Name"
            cell.textFieldDidChange = {[weak self] text in
                self?.name = text
            }
            baseCell = cell
            
        case .surnameCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = workerToShow?.second_name
            cell.textField.placeholder = "Surname"
            cell.textFieldDidChange = {[weak self] text in
                self?.surname = text
            }
            baseCell = cell
            
        case .birthDayCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = workerToShow?.birthday
            cell.textField.placeholder = "Birthday"
            cell.textFieldDidChange = {[weak self] text in
                self?.birthday = text
            }
            baseCell = cell
            
        case .companyCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableViewCell", for:indexPath) as! CompanyTableViewCell
            
            cell.companyText.text = companyName ?? "Company"
            cell.companyText.text = workerToShow?.company ?? "Company"
            
            baseCell = cell
            
        case .controlButtonCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for:indexPath) as! ButtonTableViewCell
            cell.didPressControlButton = {[weak self] in
                self?.saveData()
                self?.showAlert()
            }
            baseCell = cell
        }
        
        baseCell.selectionStyle = .none
        return baseCell
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return
        }
        
        switch cellType {
        case .companyCell:
            let companiesListTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "CompanyListTableViewController") as? CompanyListTableViewController
            
            companiesListTableViewController?.delegate = self
            
            self.navigationController?.pushViewController(companiesListTableViewController!, animated: true)
        case .imageCell:
            let cell = tableView.cellForRow(at: indexPath) as! ImageTableViewCell
            cell.downloadAvatarPicture()
            cell.didLoadImage = {[weak self] (url) in
                self?.imageURL = url
            }
        default: break
        }
    }
    
    //MARK: - Core data
    private func saveData() {
        let entity = NSEntityDescription.entity(forEntityName: "WorkerEntity", in: context)!
        let worker = WorkerEntity(entity: entity, insertInto: context)
        
        worker.name = name
        worker.second_name = surname
        worker.birthday = birthday
        worker.company = companyName
        worker.image = imageURL
        
        do {
            try context.save()
        } catch (let error){
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Helpers
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
