//
//  ForecastViewModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/08.
//

import RxSwift
import RxCocoa
import Alamofire

class ForecastViewModel {
    
    let location: Location
    let output: Observable<ForecastInfo> //Observable<Result<WeatherInfo, Error>> //Output
    //let hourlyData: Observable<List>
    
    
    init() {
        self.location = Location(latitude: 36.783611, longitude: 127.004173) //대한민국 아산
        self.output = ForecastViewModel.getRequest(location)
        //Output(result: WeatherViewModel.getRequest(location))
        //self.hourlyData =
    }
    
//    struct Output {
//        let result: Observable<Result<WeatherInfo, Error>>
//    }
    
    static func getRequest(_ location: Location) -> Observable<ForecastInfo> { // Observable<Result<WeatherInfo, Error>> {
    
        // 1 url request
        let strUrl = ForecastAPIHeader.url
        let parameters: [String:String] = [
            "lon": "\(location.longitude)",
            "lat": "\(location.latitude)",
            "appid": ForecastAPIHeader.apiKey
        ]

        return Observable.create { observer -> Disposable in
            
            // 2 Alamofire
            AF.request(strUrl,
                       method: .get,
                       parameters:  parameters
            ).responseDecodable(of: ForecastInfo.self) { response in
//                debugPrint(response)
                switch response.result {
                case .success(let data):
                    observer.onNext(data)//(.success(data))
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    
    
    /*
    static func get(_ location: Location) -> Observable<Result<WeatherInfo, Error>> {
        print("뷰모델")
        
        let weatherAPI = WeatherAPI() //API호출하는 클래스의 인스턴스 선언
        
        // Observable: subscribe 전까지 아무일도 일어나지 않음
        //-> 구독 후 이벤트가 발생하고 complete 또는 error 이벤트가 발생하기 전까지 next 이벤트가 발생함
        
        // create: observer들에게 어떤 event가 발생하는지 알려줌
        
        return Observable.create({ observer -> Disposable in
            // observer가 이벤트를 받고 있다.
            weatherAPI.getWeatherData(location) { (weatherInfo, error) in
                if let weatherInfo = weatherInfo, error == nil {
                    observer.onNext(.success(weatherInfo))
                }else {
                    print(error ?? "")
                    observer.onError(error ?? "")
                }
            }
            return Disposables.create()
        })
        
    }
    */
    lazy var data: Driver<[ForecastInfo]> = {
        
        return Observable.of([ForecastInfo]()).asDriver(onErrorJustReturn: [])
    }()
    
    
}
