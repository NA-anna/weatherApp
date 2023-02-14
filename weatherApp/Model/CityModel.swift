//
//  CityModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import Foundation

struct CityElement: Hashable, Codable {
    var id: Int
    var name: String
    var country: String
    var coord: Coordinates
    
    struct Coordinates: Hashable, Codable {
        var lon: Double
        var lat: Double
    }
}

