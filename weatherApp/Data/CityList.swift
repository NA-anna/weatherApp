//
//  CityList.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/15.
//

import Foundation

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
