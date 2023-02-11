//
//  HourlyCollectionViewCell.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let lblTime : UILabel = {
        let label = UILabel()
        label.text = "지금"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let img : UIImageView = { // 이미지 생성
        let imgView = UIImageView()
        imgView.image = UIImage(named: "01d")
        return imgView
    }()
    let label : UILabel = {
        let label = UILabel()
        label.text = "날씨"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addContentView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addContentView() {
        contentView.addSubview(lblTime)
        contentView.addSubview(img)
        contentView.addSubview(label)
    }
    private func autoLayout() {
        
        img.contentMode = .scaleToFill
        lblTime.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()//equalTo(0)
        }
        img.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()//equalTo(0)
            make.top.equalTo(lblTime.snp.bottom)
            make.bottom.equalToSuperview().inset(50)
        }
        label.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview() //equalTo(0)
            make.top.equalTo(img.snp.bottom)
        }
    }
    
}
