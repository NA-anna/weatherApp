//
//  ViewController.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/07.
//

import UIKit
import SnapKit
import MapKit

class ViewController: UIViewController {


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
    var tblVwHoursWeather = { () -> UITableView in
        let tableView = UITableView()
        return tableView
    }()
    lazy var mapView = { () -> MKMapView in
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 5
        return mapView
        
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // background color
        view.backgroundColor = UIColor(red: 114/255, green: 145/255, blue: 192/255, alpha: 1)
        
        // add View
        view.addSubview(lblCity)
        view.addSubview(lblDegree)
        view.addSubview(lblWeather)
        view.addSubview(lblMaxMinDegree)
        view.addSubview(tblVwHoursWeather)
        view.addSubview(mapView)
        
        
        // layout by Snapkit
        lblCity.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
           // make.width.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            //make.centerX.equalToSuperview()

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
        tblVwHoursWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.lblMaxMinDegree.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.tblVwHoursWeather.snp.bottom).offset(10)
            make.height.equalTo(800)
        }
        
        let location = Location(latitude: 36.783611, longitude: 127.004173)
        getWeatherData(location) { data in
            print("----")
            print(data)
        }
        // Navigation Controller
//        self.navigationItem.title = "날씨 앱"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        // -- UISearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "도시 검색"
        self.navigationItem.searchController = searchController
        
    }
//    // 빈 화면 터치 시 키보드 내려가기
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }


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
