//
//  ButtonTableViewCell.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    public var didPressControlButton: (() ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction private func saveButtonTapped(_ sender: Any) {
        didPressControlButton?()
    }
    
}
