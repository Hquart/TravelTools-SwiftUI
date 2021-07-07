//
//  Weather.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 13/02/2021.
//

import Foundation

struct Weather: Decodable {
    let list: [List]?
    
    init(list: [List]? = nil) {
        self.list = list
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
struct List: Decodable {
    let weather: [WeatherElement]
    let main: Main
    let name: String
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
struct Main: Decodable {
    let temp: Double
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
struct WeatherElement: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
