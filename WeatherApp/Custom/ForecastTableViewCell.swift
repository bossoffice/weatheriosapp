//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var firstRow: UIView!
    @IBOutlet weak var secondRow: UIView!
    
    @IBOutlet weak var firstTime: TimeWeatherView!
    @IBOutlet weak var secondTime: TimeWeatherView!
    @IBOutlet weak var thirdTime: TimeWeatherView!
    @IBOutlet weak var fourthTime: TimeWeatherView!
    @IBOutlet weak var fifthTime: TimeWeatherView!
    @IBOutlet weak var sixthTime: TimeWeatherView!
    @IBOutlet weak var sevenTime: TimeWeatherView!
    @IBOutlet weak var eightTime: TimeWeatherView!
    
    lazy var getAllTimer: [TimeWeatherView] = {
        return [firstTime ,secondTime ,thirdTime ,fourthTime ,fifthTime ,sixthTime ,sevenTime ,eightTime]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupForecast(dailyList: [DailyList]) {
        for (index ,item) in dailyList.enumerated() {
            let weather = item.weather?.first
            let date = convertToDate(str: item.dtTxt ?? "")!
            let newFormat = convertToString(date: date ,format: .shortTime)
            let imageAPI = ForecastProvider.getImagePath(iconName: weather?.icon ?? "")
            let currentTimerView = getAllTimer[index]
            currentTimerView.imageView.loadImage(url: imageAPI)
            currentTimerView.weatherLabel.text = weather?.main ?? ""
            currentTimerView.timeLabel.text = newFormat
            currentTimerView.alpha = 1
            
        }
        
        // check value available
        firstRow.isHidden = getAllTimer.first!.weatherLabel.text!.isEmpty
        secondRow.isHidden = getAllTimer[4].weatherLabel.text!.isEmpty
    }

}
