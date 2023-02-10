//
//  CityModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    
    var name: String?
    var latitude: Double
    var longitude: Double
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}


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
var cityList: [CityElement] = loadFile("citylist.json")

func loadFile<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else { fatalError() } // return [Landmark]() 아니면 빈 어레이를 반환하던지
    
    do {
        data = try Data(contentsOf: fileURL)
    }catch {
        fatalError(error.localizedDescription)
    }
    do {
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }catch {
        fatalError(error.localizedDescription)
    }
}
