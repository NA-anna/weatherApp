//
//  WeatherAPIModel.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/09.
//

import Foundation

struct WeatherInfo: Codable {

  var coord      : Coord?     = Coord()
  var weather    : [Weather]? = []
  var base       : String?    = nil
  var main       : Main?      = Main()
  var visibility : Int?       = nil
  var wind       : Wind?      = Wind()
  var clouds     : Clouds?    = Clouds()
  var dt         : Int?       = nil
  var sys        : Sys2?      = Sys2()
  var timezone   : Int?       = nil
  var id         : Int?       = nil
  var name       : String?    = nil
  var cod        : Int?       = nil

  enum CodingKeys: String, CodingKey {
    case coord      = "coord"
    case weather    = "weather"
    case base       = "base"
    case main       = "main"
    case visibility = "visibility"
    case wind       = "wind"
    case clouds     = "clouds"
    case dt         = "dt"
    case sys        = "sys"
    case timezone   = "timezone"
    case id         = "id"
    case name       = "name"
    case cod        = "cod"  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    coord      = try values.decodeIfPresent(Coord.self     , forKey: .coord      )
    weather    = try values.decodeIfPresent([Weather].self , forKey: .weather    )
    base       = try values.decodeIfPresent(String.self    , forKey: .base       )
    main       = try values.decodeIfPresent(Main.self      , forKey: .main       )
    visibility = try values.decodeIfPresent(Int.self       , forKey: .visibility )
    wind       = try values.decodeIfPresent(Wind.self      , forKey: .wind       )
    clouds     = try values.decodeIfPresent(Clouds.self    , forKey: .clouds     )
    dt         = try values.decodeIfPresent(Int.self       , forKey: .dt         )
    sys        = try values.decodeIfPresent(Sys2.self       , forKey: .sys        )
    timezone   = try values.decodeIfPresent(Int.self       , forKey: .timezone   )
    id         = try values.decodeIfPresent(Int.self       , forKey: .id         )
    name       = try values.decodeIfPresent(String.self    , forKey: .name       )
    cod        = try values.decodeIfPresent(Int.self       , forKey: .cod        )
 
  }

  init() {

  }

}


struct Sys2: Codable {

  var type    : Int?    = nil
  var id      : Int?    = nil
  var country : String? = nil
  var sunrise : Int?    = nil
  var sunset  : Int?    = nil

  enum CodingKeys: String, CodingKey {
    case type    = "type"
    case id      = "id"
    case country = "country"
    case sunrise = "sunrise"
    case sunset  = "sunset"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    type    = try values.decodeIfPresent(Int.self    , forKey: .type    )
    id      = try values.decodeIfPresent(Int.self    , forKey: .id      )
    country = try values.decodeIfPresent(String.self , forKey: .country )
    sunrise = try values.decodeIfPresent(Int.self    , forKey: .sunrise )
    sunset  = try values.decodeIfPresent(Int.self    , forKey: .sunset  )
 
  }

  init() {

  }

}



/*
 
 struct Main: Codable {

   var temp      : Double? = nil
   var feelsLike : Double? = nil
   var tempMin   : Double? = nil
   var tempMax   : Double? = nil
   var pressure  : Int?    = nil
   var humidity  : Int?    = nil
   var seaLevel  : Int?    = nil
   var grndLevel : Int?    = nil

   enum CodingKeys: String, CodingKey {
     case temp      = "temp"
     case feelsLike = "feels_like"
     case tempMin   = "temp_min"
     case tempMax   = "temp_max"
     case pressure  = "pressure"
     case humidity  = "humidity"
     case seaLevel  = "sea_level"
     case grndLevel = "grnd_level"
   }

   init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)

     temp      = try values.decodeIfPresent(Double.self , forKey: .temp      )
     feelsLike = try values.decodeIfPresent(Double.self , forKey: .feelsLike )
     tempMin   = try values.decodeIfPresent(Double.self , forKey: .tempMin   )
     tempMax   = try values.decodeIfPresent(Double.self , forKey: .tempMax   )
     pressure  = try values.decodeIfPresent(Int.self    , forKey: .pressure  )
     humidity  = try values.decodeIfPresent(Int.self    , forKey: .humidity  )
     seaLevel  = try values.decodeIfPresent(Int.self    , forKey: .seaLevel  )
     grndLevel = try values.decodeIfPresent(Int.self    , forKey: .grndLevel )
  
   }

   init() {

   }

 }
 
struct Weather: Codable {

   var id          : Int?    = nil
   var main        : String? = nil
   var description : String? = nil
   var icon        : String? = nil

   enum CodingKeys: String, CodingKey {
     case id          = "id"
     case main        = "main"
     case description = "description"
     case icon        = "icon"
   }

   init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)

     id          = try values.decodeIfPresent(Int.self    , forKey: .id          )
     main        = try values.decodeIfPresent(String.self , forKey: .main        )
     description = try values.decodeIfPresent(String.self , forKey: .description )
     icon        = try values.decodeIfPresent(String.self , forKey: .icon        )
  
   }

   init() {

   }

 }
 
struct Wind: Codable {

  var speed : Double? = nil
  var deg   : Int?    = nil
  var gust  : Double? = nil

  enum CodingKeys: String, CodingKey {
    case speed = "speed"
    case deg   = "deg"
    case gust  = "gust"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    speed = try values.decodeIfPresent(Double.self , forKey: .speed )
    deg   = try values.decodeIfPresent(Int.self    , forKey: .deg   )
    gust  = try values.decodeIfPresent(Double.self , forKey: .gust  )
 
  }

  init() {

  }

}

struct Clouds: Codable {

  var all : Int? = nil

  enum CodingKeys: String, CodingKey {

    case all = "all"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    all = try values.decodeIfPresent(Int.self , forKey: .all )
 
  }

  init() {

  }

}

 struct Coord: Codable {

   var lon : Double? = nil
   var lat : Double? = nil

   enum CodingKeys: String, CodingKey {
     case lon = "lon"
     case lat = "lat"
   }

   init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)

     lon = try values.decodeIfPresent(Double.self , forKey: .lon )
     lat = try values.decodeIfPresent(Double.self , forKey: .lat )
  
   }

   init() {

   }

 }
 */

