//
//  ViewController.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MapKit

class ViewController: UIViewController {
    
    // RxSwift - observable 종료 후 메모리 누수를 막기 위해 이를 담아 해제해줄 disposeBag을 만듬
    var disposeBag = DisposeBag()
    
    var defaultBackgroundColor = UIColor.systemBackground//UIColor(red: 114/255, green: 145/255, blue: 192/255, alpha: 1)
    
    // for CollectionView 간격
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    
    // UIScrollView
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // UILabel()
    lazy var lblCity = { () -> UILabel in
        let label = UILabel()
        label.text = "City"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        
        return label
    }()
    lazy var lblDegree = { () -> UILabel in
        let label = UILabel()
        label.text = "-7"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 80)
        return label
    }()
    lazy var lblWeather = { () -> UILabel in
        let label = UILabel()
        label.text = "맑음"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    lazy var lblMaxMinDegree = { () -> UILabel in
        let label = UILabel()
        label.text = "최고온도 | 최저온도"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    var tblVwHourlyWeather = { () -> UITableView in
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    // 콜렉션 뷰 생성
    private let cltVwHourlyWeather : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) //.zero
        //layout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        return collectionView
    }()
    // 테이블 뷰 생성
    private let tblVwDailyWeather : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50
        tableView.backgroundColor = .clear
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        return tableView
    }()
    lazy var mapView = { () -> MKMapView in
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 10
        return mapView
        
    }()
    private let vwHuminity: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    private let lblHuminityTitle: UILabel = {
        let label = UILabel()
        label.text = "습도"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    private let lblHuminityValue: UILabel = {
        let label = UILabel()
        label.text = "33%"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    private let vwClouds: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    private let lblCloudsTitle: UILabel = {
        let label = UILabel()
        label.text = "구름"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    private let lblCloudsValue: UILabel = {
        let label = UILabel()
        label.text = "33%"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    private let vwWind: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    private let lblWindTitle: UILabel = {
        let label = UILabel()
        label.text = "바람"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    private let lblWindValue: UILabel = {
        let label = UILabel()
        label.text = "33m/s"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let vwPressure: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    private let lblPressureTitle: UILabel = {
        let label = UILabel()
        label.text = "기압"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    private let lblPressureValue: UILabel = {
        let label = UILabel()
        label.text = "33hpa"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // background color
        //view.backgroundColor = defaultBackgroundColor
        
        // Navigation Controller
        self.navigationItem.title = "날씨"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        // -- UISearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "도시 검색"
        searchController.searchBar.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        
        
        
        cltVwHourlyWeather.delegate = self
        
        
        // UI
        addSubView()    // add View
        autoLayout()    // layout by Snapkit
        
        // Data
        bindWeather()
        bindForecast()
        
    }
    
}

extension ViewController {
    
    // add View
    private func addSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        _ = [lblCity, lblDegree, lblWeather, lblMaxMinDegree,
             //cltVwHourlyWeather,
             tblVwHourlyWeather, tblVwDailyWeather,
             mapView].map{ self.contentView.addSubview($0)}
        contentView.addSubview(cltVwHourlyWeather)
        contentView.addSubview(vwHuminity)
        vwHuminity.addSubview(lblHuminityTitle)
        vwHuminity.addSubview(lblHuminityValue)
        contentView.addSubview(vwClouds)
        vwClouds.addSubview(lblCloudsTitle)
        vwClouds.addSubview(lblCloudsValue)
        contentView.addSubview(vwWind)
        vwWind.addSubview(lblWindTitle)
        vwWind.addSubview(lblWindValue)
        contentView.addSubview(vwPressure)
        vwPressure.addSubview(lblPressureTitle)
        vwPressure.addSubview(lblPressureValue)
        
        
    }
    
    // layout by Snapkit
    private func autoLayout() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
            //make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        lblCity.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        lblDegree.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.lblCity.snp.bottom).offset(10)
        }
        lblWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.lblDegree.snp.bottom).offset(10)
        }
        lblMaxMinDegree.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.lblWeather.snp.bottom).offset(10)
        }
        cltVwHourlyWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.lblMaxMinDegree.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        tblVwDailyWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.cltVwHourlyWeather.snp.bottom).offset(10)
            make.height.equalTo(250)
        }
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.tblVwDailyWeather.snp.bottom).offset(10)
            make.height.equalTo(self.mapView.snp.width)
        }
        vwHuminity.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.mapView.snp.bottom).offset(10)
            make.trailing.equalTo(self.view.snp.centerX).offset(-5)
            make.height.equalTo(self.vwHuminity.snp.width)
        }
        vwClouds.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.centerX).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.mapView.snp.bottom).offset(10)
            make.height.equalTo(self.vwClouds.snp.width)
        }
        vwWind.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.vwHuminity.snp.bottom).offset(10)
            make.trailing.equalTo(self.view.snp.centerX).offset(-5)
            make.height.equalTo(self.vwWind.snp.width)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
        vwPressure.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.centerX).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.vwClouds.snp.bottom).offset(10)
            make.height.equalTo(self.vwPressure.snp.width)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
        lblHuminityTitle.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.vwHuminity.snp.height).dividedBy(3)
        }
        lblHuminityValue.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(lblHuminityTitle.snp.bottom)
        }
        lblCloudsTitle.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.vwHuminity.snp.height).dividedBy(3)
        }
        lblCloudsValue.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(lblCloudsTitle.snp.bottom)
        }
        lblWindTitle.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.vwHuminity.snp.height).dividedBy(3)
        }
        lblWindValue.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(lblWindTitle.snp.bottom)
        }
        lblPressureTitle.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.vwHuminity.snp.height).dividedBy(3)
        }
        lblPressureValue.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(lblPressureTitle.snp.bottom)
        }
    }
    
    
    // Data
    private func bindWeather() {
        
        // 🚨 disposed만 쓰면 통신보다 dispose가 먼저 진행되는 문제가 생김 (dispose 후 통신 success가 되나 구독이 끊어져서 onNext가 실행되지 않음)
        // 💡 문제는 bind() 함수 내에서 선언된 DisposeBag()
        //    -> ViewController 내에 선언함으로 해결
        
        let viewModel = WeatherViewModel()
        viewModel.output.subscribe(
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
        
    }
    private func displayWeather(_ weatherInfo: WeatherInfo) {
        
        if let cityName = weatherInfo.name,
           let weather = weatherInfo.weather,
           let main = weatherInfo.main,
           let weatherName = weather[0].main,
           let temp = main.temp,
           let tempMax = main.tempMax,
           let tempMin = main.tempMin,
           let coord = weatherInfo.coord, let lat = coord.lat, let lon = coord.lon,
           let humidity = main.humidity,
           let clouds = weatherInfo.clouds, let cloudsVal = clouds.all,
           let wind = weatherInfo.wind, let speed = wind.speed,
           let pressure = main.pressure
        {
            print(weatherName, weatherName.lowercased())
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
    
    private func bindForecast() {
        
        let viewModel = ForecastViewModel()
   
        viewModel.filtered.map{$0.hourly}//listData
            .bind(to: cltVwHourlyWeather.rx.items(cellIdentifier: HourlyCollectionViewCell.identifier, cellType: HourlyCollectionViewCell.self)) { index, item, cell in
                self.displayHourlyForecast(item, cell)
            }.disposed(by: disposeBag)
        
        viewModel.filtered.map{$0.daily}//listData
            .bind(to: tblVwDailyWeather.rx.items(cellIdentifier: DailyTableViewCell.identifier, cellType: DailyTableViewCell.self)) { index, item, cell in
                self.displayDailyForecast(item, cell)
            }.disposed(by: disposeBag)
        
        
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

 

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = collectionView.frame.height
         
         return CGSize(width: height*2/3, height: height)
    }
    
    // case A
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

}
 


//
// cmd+opt+enter    cmd+opt+P
//
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController{
        ViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
        
    }
} #endif
