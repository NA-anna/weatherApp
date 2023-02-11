//
//  SearchViewController.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

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
        
        
        print("하하", cityList.count)
    }

}
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let city = cityList[indexPath.row]
        cell.backgroundColor = .clear
        cell.setValues(element: city, index : indexPath.row)

        return cell
    }
    
    
}
