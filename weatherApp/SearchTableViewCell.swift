//
//  SearchTableViewCell.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let lblCountry : UILabel = {
        let label = UILabel()
        label.text = "나라"
        //label.textColor = .white
        return label
    }()
    let lblCity : UILabel = {
        let label = UILabel()
        label.text = "도시"
        //label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(lblCountry)
        contentView.addSubview(lblCity)
    }
    private func autoLayout() {
        lblCountry.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.size.width.equalTo(90)
        }
        lblCity.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(lblCountry.snp.trailing).offset(5)
            
        }
    }
    func setValues(element: CityElement, index: Int) {
        
        lblCountry.text = element.country
        lblCity.text = element.name
        
    }

}
