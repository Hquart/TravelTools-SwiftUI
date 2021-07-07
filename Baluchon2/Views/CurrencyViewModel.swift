////
////  FixerAPI.swift
////  myBaluchon2
////
////  Created by Naji Achkar on 09/02/2021.
////

import Foundation
import Combine
import SwiftUI
    
final class CurrencyViewModel: ObservableObject {
    
    @Published var input: String = ""
    @Published var output: String = ""
    @Published var showAlert: Bool = false
    
    var exRates = Currency()
    var destinationSelected: Int = 0
    
    private var cancellable: AnyCancellable?
    
    private var baseURL: String = "http://data.fixer.io/api/latest"
    private var parameters: [String: String] {
        return [
            "access_key": APIKeys.fixer,
            "base": "EUR",
            "symbols": "USD, MXN, GBP, RUB, LBP, JPY"
        ]
    }
    init() {
        cancellable =
            getRates(baseURL: baseURL, parameters: parameters)
            .receive(on: DispatchQueue.main)
            .catch { _ in Just(self.exRates) }
            .assign(to: \.exRates, on: self)
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: METHODS
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRates(baseURL: String, parameters: [String : String]) -> AnyPublisher<Currency, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher()
        }
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Currency.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    func convert() {
        guard let inputValue = Double(input) else {
            showAlert.toggle()
            return }
        guard let rate = exRates.rates?[Destination.currency[self.destinationSelected]] else {
            return  }
                let formatedOutput = self.formatResult(rate * inputValue)
                self.output = String(formatedOutput) + " " + Destination.currency[self.destinationSelected]
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    func formatResult(_ result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        guard let formatedResult = formatter.string(from: NSNumber(value: result)) else {
            return String()
        }
        return formatedResult
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
enum NetworkingError: String, Error {
    
    case URLError = "there is a problem with the URL"
    case serverResponseError = "error server reponse"
    case decodeError = "Data can't be decoded !"
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
extension URLComponents {
    // This func will map [String: String] parameters to URLQueryItems
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
