//
//  TimeWeatherView.swift
//  WeatherApp
//
//  Created by gable006973 on 23/3/2566 BE.
//

import UIKit

class TimeWeatherView: BaseUIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override var viewIdentifier: String {
        get {
            return "TimeWeatherView"
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
