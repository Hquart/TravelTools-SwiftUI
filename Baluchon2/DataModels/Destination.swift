//
//  Destination.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 08/02/2021.
//  // https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper

import SwiftUI
import Foundation
import Combine

class Destination: ObservableObject {
    
    @Published var selection: Int {
        didSet {
            UserDefaults.standard.set(selection, forKey: "destination")
        }
    }
    
    init() {
        self.selection = UserDefaults.standard.object(forKey: "destination") as? Int ?? 1
    }
    
    static let name = ["NewYork", "Mexico", "London", "Moscow", "Beyrouth", "Tokyo"] // used both for city name and city image
    static let cityId: [String] = ["5128638", "3530597", "2643743","524901","276781", "1850144"] //  weather parameter
    static let languageSymbol: [String] = ["en", "es", "en", "ru", "ar", "ja"] // translation parameter
    static let currency: [String] = ["USD", "MXN", "GBP", "RUB", "LBP", "JPY"] // currency parameter
    static let currencyImage: [String] = ["dollarsign.square", "pesosign.square", "sterlingsign.square", "rublesign.square", "lirasign.square", "yensign.square"] // currency Image background
    static let flag: [String] = ["USA", "MEXI", "UK", "RUSS", "LIB", "JAP"] // flag background image
}


