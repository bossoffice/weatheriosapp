//
//  ViewExtension.swift
//  WeatherApp
//
//  Created by gable006973 on 22/3/2566 BE.
//

import Foundation
import UIKit

extension UIView {
    func applyRound(borderWidth: CGFloat = 1 ,color: CGColor = UIColor.clear.cgColor ,conerRadius: CGFloat = 8) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color
        self.layer.cornerRadius = conerRadius
    }
}
