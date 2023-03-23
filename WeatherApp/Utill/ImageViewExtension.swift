//
//  ImageViewExtension.swift
//  WeatherApp
//
//  Created by gable006973 on 22/3/2566 BE.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                   let imageFromData = UIImage(data: data)
                   if let imageFromData {
                       self.image = imageFromData
                   }
           }
        }
    }
}
