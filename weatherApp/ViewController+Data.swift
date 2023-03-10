//
//  ViewController+Data.swift
//  weatherApp
//
//  Created by ๋์ ์ง on 2023/02/15.
//

import Foundation
import UIKit
import MapKit

// Data
extension ViewController {
    
    func bind(location: Location?) {
        
        // ๐จ disposed๋ง ์ฐ๋ฉด ํต์ ๋ณด๋ค dispose๊ฐ ๋จผ์  ์งํ๋๋ ๋ฌธ์ ๊ฐ ์๊น (dispose ํ ํต์  success๊ฐ ๋๋ ๊ตฌ๋์ด ๋์ด์ ธ์ onNext๊ฐ ์คํ๋์ง ์์)
        // ๐ก ๋ฌธ์ ๋ bind() ํจ์ ๋ด์์ ์ ์ธ๋ DisposeBag()
        //    -> ViewController ๋ด์ ์ ์ธํจ์ผ๋ก ํด๊ฒฐ
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
            self.lblDegree.text = "\(Temperature(kelvin: temp).toCelcius)ยบ"
            self.lblWeather.text = weatherName
            self.lblMaxMinDegree.text = "์ต๊ณ  \(Temperature(kelvin: tempMax).toCelcius)ยบ | ์ต์  \(Temperature(kelvin: tempMin).toCelcius)ยบ"
            
            // ์ง๋ mapView
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.region = region
            
            // ์ต๋ ๊ตฌ๋ฆ
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
        cell.label.text = "\(Temperature(kelvin: temp).toCelcius)ยบ"
        
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
        cell.label.text = "์ต๊ณ  \(Temperature(kelvin: tempMin).toCelcius)ยบ ์ต์  \(Temperature(kelvin: tempMax).toCelcius)ยบ"
    }
    
    

}
