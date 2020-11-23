//
//  ImageTableViewCell.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
