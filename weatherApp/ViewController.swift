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
    
    var defaultBackgroundColor = UIColor(red: 114/255, green: 145/255, blue: 192/255, alpha: 1)
    
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
    let collectionVwHourlyWeather : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero  //초기값으로 선언
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        return collectionView
    }()
    // 테이블 뷰 생성
    let tblVwDailyWeather : UITableView = {
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
    let vwHuminity: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    let lblHuminityTitle: UILabel = {
        let label = UILabel()
        label.text = "습도"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    let lblHuminityValue: UILabel = {
        let label = UILabel()
        label.text = "33%"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    let vwClouds: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    let lblCloudsTitle: UILabel = {
        let label = UILabel()
        label.text = "구름"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    let lblCloudsValue: UILabel = {
        let label = UILabel()
        label.text = "33%"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    let vwWind: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    let lblWindTitle: UILabel = {
        let label = UILabel()
        label.text = "바람"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    let lblWindValue: UILabel = {
        let label = UILabel()
        label.text = "33m/s"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let vwPressure: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    let lblPressureTitle: UILabel = {
        let label = UILabel()
        label.text = "기압"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:20)
        return label
    }()
    let lblPressureValue: UILabel = {
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
        
        collectionVwHourlyWeather.delegate = self
        
        // background color
        view.backgroundColor = .systemBackground
        
        // UISearchController
        configureSearchController()
        
        // UI
        addSubView()    // add View
        autoLayout()    // layout by Snapkit
        
        
        // Data
        bind(location: nil)
        
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//
//
//        disposeBag = DisposeBag() // reuse 시 disposebag을 초기화
//        print("뷰")
//
//        bind(location: Location(latitude: 36.783611, longitude: 127.004173))
//
//
//    }
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
