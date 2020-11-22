//
//  InfoLabelTableViewCell.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var companyText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
