//
//  WeatherAPI.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/08.
//

import Foundation
import Alamofire

//==================api Header Info======================//
let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?"
let apiKey = "f8ad3cf3aa1e0f2df6433c805e65ca58"
//======================================================//

func getWeatherData(_ location: Location, handler: @escaping(Any)->() ) {
    
    // 1 url request
    let strUrl = weatherURL

    let parameters: [String:String] = [
        "lon": "\(location.longitude)",
        "lat": "\(location.latitude)",
        "appid": apiKey
    ]
    
    // 2 Alamofire
    AF.request(
        strUrl,
        method: .get,
        parameters:  parameters
    ).responseDecodable(of: WeatherInfo.self) { response in
        //debugPrint(response)
        switch response.result {
        case .success( _): //obj):
            guard let data = response.value else { fatalError() }
            //let documents = data
            //markets = documents
            handler(data)
        case .failure(let e):
            print(e.localizedDescription)
        }
    }
}
