//
//  UIImageView+Extension.swift
//  Intership
//
//  Created by Елена Кириленко on 25.11.2020.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, completion: ((URL?) -> ())?) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = image
                    completion?(response?.url)
                }
            }
        }).resume()
    }
}
