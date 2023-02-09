//
//  Temperature.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/09.
//

import Foundation

class Temperature {
    
    static let celciusGap = 273.15
    let kelvinValue: Double
    
    init(kelvin: Double) {
        self.kelvinValue = kelvin
    }
    
    var toCelcius: Int {
        return Int(kelvinValue - Temperature.celciusGap)
    }
    

}
