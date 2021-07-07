//
//  OpenWeatherAPI.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 13/02/2021.
//

import Foundation
import SwiftUI
import Combine

final class WeatherViewModel: ObservableObject  {
    
    var destinationSelected: Int = 0
    
    @Published var temp: String = ""
    @Published var image: String = "placeholderWeather"
    @Published var conditions: String = ""
    
    private var weather = Weather()
    private var cancellable: AnyCancellable?
    private var baseUrl: String = "http://api.openweathermap.org/data/2.5/group"
    
    var homeCity: Bool
    
    private var parameters: [String : String] {
        return [
            "appid": APIKeys.openWeather,
            "id": homeCity ? "2988507" : "\(Destination.cityId[destinationSelected])",
            "units": "metric"
        ]
    }
    //////////////////////////////////// /INITIALIZER ////////////////////////////////////////////////////////////////////
    init(destination: Int, homeCity: Bool) {
        self.destinationSelected = destination
        self.homeCity = homeCity
        updateWeather()
    }
    ///////////////////////////////////////// PREVIEW INITIALIZER //////////////////////////////////////////////////////////////
    // Used for WeatherBlock Preview
    init(temp: String, image: String, conditions: String, homeCity: Bool) {
        self.temp = temp
        self.image = image
        self.conditions = conditions
        self.homeCity = homeCity
    }
    ///////////////////////////////// METHODS /////////////////////////////////////////////
    func getWeather(baseURL: String, parameters: [String : String]) -> AnyPublisher<Weather, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher()
        }
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher() // type eraser method to return AnyPublisher Type
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    func updateWeather() {
        cancellable =
            getWeather(baseURL: baseUrl, parameters: parameters)
            .receive(on: DispatchQueue.main)
            .catch { _ in Just(self.weather) } // Just: A publisher that emits an output to each subscriber just once, and then finishes
           
            .sink(receiveValue: {
                self.temp = String($0.list?[0].main.temp ?? 0)
                self.image = String($0.list?[0].weather[0].icon ?? "placeholderWeather")
                self.conditions = String($0.list?[0].weather[0].weatherDescription ?? "no info available")
                
            })
    }
}




