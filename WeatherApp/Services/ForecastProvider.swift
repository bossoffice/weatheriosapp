//
//  ForecastProvider.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

let Forecast_API_Key = "204a5ccadfa281436191b507d968c567"
//ForecastCityModel
let ForecastImage_API = "https://openweathermap.org/img/wn/"
//10d@4x.png

class ForecastProvider {
    static func getCurrentWeather(keyword: String = "Bangkok", unit: ForecastUnit = .metric) async -> WeatherCityModel? {
        let decoder = JSONDecoder()
        let request = AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(keyword)&units=\(unit.rawValue)&appid=\(Forecast_API_Key)",method: .get).serializingData()
        
        let response = await request.response
//        let result = response.result // use for debug
        let value = response.value
        
        if let data = value {
            let returnResponse = try? decoder.decode(WeatherCityModel.self, from: data)
//            let some = try? JSON.init(data: data) // use for debug
            return returnResponse
        }
        return nil

    }
    
    static func getDailyForecast(keyword: String = "Bangkok", unit: ForecastUnit = .metric) async -> ForecastDaily? {
        let decoder = JSONDecoder()
        let parameter:Parameters = ["q" : keyword ,"appid" : Forecast_API_Key]
    
        let request = AF.request("https://api.openweathermap.org/data/2.5/forecast",method: .get, parameters: parameter).serializingData()

        let response = await request.response
        let value = response.value

        if let data = value {
            let returnResponse = try? decoder.decode(ForecastDaily.self, from: data)
            return returnResponse
        }
        return nil

    }
    
    static func getImagePath(iconName: String) -> String {
        let str = ForecastImage_API + iconName + "@4x.png"
        return str
    }
}

