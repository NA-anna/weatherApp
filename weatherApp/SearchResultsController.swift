//
//  SearchResultsController.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchResultsController: UIViewController, UISearchResultsUpdating {
    
    // RxSwift - observable 종료 후 메모리 누수를 막기 위해 이를 담아 해제해줄 disposeBag을 만듬
    var disposeBag = DisposeBag()
    
    var items: [CityElement] = cityList
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        searchController.searchBar
            .rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)   //0.5초 기다림
            .distinctUntilChanged()   // 같은 아이템을 받지 않는기능
            .subscribe(onNext: { t in
                self.items = cityList.filter{ $0.name.hasPrefix(t) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    

    // 테이블 뷰 생성
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // autoLayout
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    
    func bind() {
        
    }
    

    

}
extension SearchResultsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let city = items[indexPath.row]
        cell.backgroundColor = .clear
        cell.setValues(element: city, index : indexPath.row)
        
        return cell
    }
    
}
extension SearchResultsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell: SearchTableViewCell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell else { return }
     
        print("시티는?", cell.lblCity)
    }
    
}
