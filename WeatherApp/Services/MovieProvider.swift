//
//  MovieProvider.swift
//  WeatherApp
//
//  Created by gable006973 on 21/3/2566 BE.
//

import Foundation
import Alamofire

class MovieProvider {
    static func getMovie() async -> MovieModel? {
        let decoder = JSONDecoder()
        let request = AF.request("https://www.majorcineplex.com/apis/get_movie_avaiable",method: .get).serializingData()
        
        let response = await request.response
        let result = response.result
        let value = response.value
        
        if let data = value {
            let returnResponse = try? decoder.decode(MovieModel.self, from: data)
            return returnResponse
        }
        return nil

    }
}
