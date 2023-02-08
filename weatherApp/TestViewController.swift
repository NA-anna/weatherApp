//
//  TestViewController.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/08.
//

import UIKit
import SnapKit

class TestViewController: UIViewController{//}, UITextFieldDelegate {

    var redView = UIView()
    var orangeView = UIView()
    var yellowView = UIView()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(redView)
        self.view.addSubview(orangeView)
        self.view.addSubview(yellowView)

        
        redView.backgroundColor = .red
        orangeView.backgroundColor = .orange
        yellowView.backgroundColor = .yellow

        
        redView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(view.snp.left)
        }
        orangeView.snp.makeConstraints { make in
            make.top.equalTo(redView.snp.bottom)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(redView.snp.left)
        }
        yellowView.snp.makeConstraints { make in
            make.top.equalTo(orangeView.snp.bottom)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(orangeView.snp.left)
        }

    }
    


}
