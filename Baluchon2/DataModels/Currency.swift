//
//  ExchangeRate.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 09/02/2021.
//

import Foundation

struct Currency: Decodable {
    
    var rates: [String: Double]?
    
    init(rates: [String: Double]? = nil) {
        self.rates = rates
    }
}
