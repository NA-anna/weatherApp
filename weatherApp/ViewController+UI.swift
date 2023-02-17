//
//  ViewController+extension.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/14.
//

import Foundation
import UIKit

// UI
extension ViewController {
    
    // UISearchController
    func configureSearchController() {
        
        //Search Controller
        let resultsController = SearchResultsController()
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.placeholder = "도시 검색"
        searchController.searchBar.showsCancelButton = false
        
        
        // Navigation Controller
        self.navigationItem.title = "날씨"  //self.title = "날씨"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.searchController = searchController
        
        
    }
    

    func addSubView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        _ = [
             lblCity, lblDegree, lblWeather, lblMaxMinDegree,
             collectionVwHourlyWeather,
             tblVwHourlyWeather, tblVwDailyWeather,
             mapView].map{ self.contentView.addSubview($0)}
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
    func autoLayout() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
            
//            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        searchView.snp.makeConstraints { make in
//            make.leading.top.trailing.equalToSuperview()
//        }
        lblCity.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(self.searchView.snp.bottom)
            
            make.leading.top.trailing.equalToSuperview()
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
        collectionVwHourlyWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.lblMaxMinDegree.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        tblVwDailyWeather.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.collectionVwHourlyWeather.snp.bottom).offset(10)
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
}
