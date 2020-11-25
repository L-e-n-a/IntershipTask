//
//  ImageTableViewCell.swift
//  Intership
//
//  Created by Елена Кириленко on 22.11.2020.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak private var avatar: UIImageView!
    
    public var didLoadImage: ((URL) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func downloadAvatarPicture () {
        
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        
        avatar.loadImage(from: url) {[weak self] (url) in
            if let imageUrl = url {
                self?.didLoadImage?(imageUrl)
            }
        }
    }
}
