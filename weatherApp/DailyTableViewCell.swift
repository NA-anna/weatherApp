//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/09.
//

import UIKit
import SnapKit

class DailyTableViewCell: UITableViewCell {
    
    static let identifier = "DailyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let lblDay : UILabel = {
        let label = UILabel()
        label.text = "요일"
        label.textColor = .white
        return label
    }()
    let img : UIImageView = { // 이미지 생성
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon")
        return imgView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "최대 최소 기온"
        label.textColor = .white
        label.textAlignment = .right
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
        contentView.addSubview(lblDay)
        contentView.addSubview(img)
        contentView.addSubview(label)
    }
    private func autoLayout() {
        lblDay.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
            make.size.width.equalTo(100)
        }
        img.snp.makeConstraints { make in
            make.leading.equalTo(lblDay.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview()
            make.size.width.equalTo(self.snp.height)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(5)
            make.top.bottom.trailing.equalToSuperview().inset(5)
            
        }
    }
    
}
