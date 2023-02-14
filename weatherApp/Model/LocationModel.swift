//
//  LocationModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/15.
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
