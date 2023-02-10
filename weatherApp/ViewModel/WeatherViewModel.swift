//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/08.
//

import RxSwift
import RxCocoa
import Alamofire

class WeatherViewModel {
    
    
    let location: Location
    let output: Observable<WeatherInfo>
    
    init() {
        self.location = Location(latitude: 36.783611, longitude: 127.004173) //대한민국 아산
        self.output = WeatherViewModel.getRequest(location)
    }
    
    
    static func getRequest(_ location: Location) -> Observable<WeatherInfo> {
    
        // 1 url request
        let strUrl = WeatherAPIHeader.url
        let parameters: [String:String] = [
            "lon": "\(location.longitude)",
            "lat": "\(location.latitude)",
            "appid": WeatherAPIHeader.apiKey,
            //"lang": "kr",
        ]

        return Observable.create { observer -> Disposable in
            
            // 2 Alamofire
            AF.request(strUrl,
                       method: .get,
                       parameters:  parameters
            ).responseDecodable(of: WeatherInfo.self) { response in
//                debugPrint(response)
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
}
