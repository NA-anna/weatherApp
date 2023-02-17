//
//  ViewController+Data.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/15.
//

import Foundation
import UIKit
import MapKit

// Data
extension ViewController {
    
    func bind(location: Location?) {
        
        // 🚨 disposed만 쓰면 통신보다 dispose가 먼저 진행되는 문제가 생김 (dispose 후 통신 success가 되나 구독이 끊어져서 onNext가 실행되지 않음)
        // 💡 문제는 bind() 함수 내에서 선언된 DisposeBag()
        //    -> ViewController 내에 선언함으로 해결
        var viewModel1 = WeatherViewModel()
        if let location = location{
            viewModel1 = WeatherViewModel(location: location)
        }
        viewModel1.output.subscribe(
            onNext: { result in
                print("onNext")
                self.displayWeather(result)
            }, onError: { error in
                print("onError", error)
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed")
            }
        ).disposed(by: disposeBag)
        
        
        var viewModel2 = ForecastViewModel()
        if let location = location{
            viewModel2 = ForecastViewModel(location: location)
        }
        viewModel2.filtered.map{$0.hourly}//listData
            .bind(to: collectionVwHourlyWeather.rx.items(cellIdentifier: HourlyCollectionViewCell.identifier, cellType: HourlyCollectionViewCell.self)) { index, item, cell in
                self.displayHourlyForecast(item, cell)
            }.disposed(by: disposeBag)
        
        viewModel2.filtered.map{$0.daily}//listData
            .bind(to: tblVwDailyWeather.rx.items(cellIdentifier: DailyTableViewCell.identifier, cellType: DailyTableViewCell.self)) { index, item, cell in
                self.displayDailyForecast(item, cell)
            }.disposed(by: disposeBag)
        
    }
    private func displayWeather(_ weatherInfo: WeatherInfo) {
        
        if let cityName = weatherInfo.name,
           let weather = weatherInfo.weather,
           let main = weatherInfo.main,
           var weatherName = weather[0].main,
           let temp = main.temp,
           let tempMax = main.tempMax,
           let tempMin = main.tempMin,
           let coord = weatherInfo.coord, let lat = coord.lat, let lon = coord.lon,
           let humidity = main.humidity,
           let clouds = weatherInfo.clouds, let cloudsVal = clouds.all,
           let wind = weatherInfo.wind, let speed = wind.speed,
           let pressure = main.pressure
        {
            if weatherName == "Clear" { weatherName = "Sunny"}
            if let backgroundImage = UIImage(named: weatherName.lowercased()) {
                self.scrollView.backgroundColor = UIColor(patternImage: backgroundImage)
            }
            self.lblCity.text = cityName
            self.lblDegree.text = "\(Temperature(kelvin: temp).toCelcius)º"
            self.lblWeather.text = weatherName
            self.lblMaxMinDegree.text = "최고 \(Temperature(kelvin: tempMax).toCelcius)º | 최저 \(Temperature(kelvin: tempMin).toCelcius)º"
            
            // 지도 mapView
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.region = region
            
            // 습도 구름
            self.lblHuminityValue.text = "\(humidity)%"
            self.lblCloudsValue.text = "\(cloudsVal)%"
            self.lblWindValue.text = "\(speed) m/s"
            self.lblPressureValue.text = "\(pressure) hpa"
        }
    }
    private func displayHourlyForecast(_ item: List, _ cell: HourlyCollectionViewCell) {
        
        guard let main = item.main , let temp = main.temp
                , let weather = item.weather, let imageName = weather[0].icon
                , let dtTxt = item.dtTxt, let date = dtTxt.toDate()
        else {return}
        
        cell.lblTime.text = date.dtToTimeWithLetter(36000)
        let idx = imageName.index(imageName.startIndex, offsetBy: 1)
        cell.img.image = UIImage(named: imageName[...idx]+"d")
        cell.label.text = "\(Temperature(kelvin: temp).toCelcius)º"
        
    }
    private func displayDailyForecast(_ item: List, _ cell: DailyTableViewCell) {
        guard let main = item.main , let tempMax = main.tempMax, let tempMin = main.tempMin
                , let weather = item.weather, let imageName = weather[0].icon
                , let dtTxt = item.dtTxt, let date = dtTxt.toDate()
        else {return}
        
        cell.backgroundColor = .clear
        cell.lblDay.text = date.toDayKR()
        let idx = imageName.index(imageName.startIndex, offsetBy: 1)
        cell.img.image = UIImage(named: imageName[...idx]+"d")
        cell.label.text = "최고 \(Temperature(kelvin: tempMin).toCelcius)º 최저 \(Temperature(kelvin: tempMax).toCelcius)º"
    }
    
    

}
