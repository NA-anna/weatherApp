//
//  searchbBar.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchButton = UIButton()
   
 
    let searhButtonTapped = PublishRelay<Void>()
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    
// -> Reative - Bind
private func bind() {

}
// -> UI - View attribution
private func attribute() {

}
// -> UI - SubviewLayout
private func layout() {

}

