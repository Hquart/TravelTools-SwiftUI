//
//  GoogleAPI.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 11/02/2021.
//
//
import Foundation
import SwiftUI
import Combine

final class TranslationViewModel: ObservableObject {
    
    @Published var input: String = ""
    @Published var output: String = ""
    @Published var showAlert: Bool = false
    
    var translation = Translation()
    var destinationSelected: Int = 0
    
    private var cancellable: AnyCancellable?
    
    private var baseURL: String = "https://translation.googleapis.com/language/translate/v2?"
    private var parameters: [String: String] {
        return [
            "key": APIKeys.google,
            "format": "text",
            "q": input,
            "target": Destination.languageSymbol[destinationSelected]
        ]
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: METHODS
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getTranslation(baseURL: String, parameters: [String : String]) -> AnyPublisher<Translation, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher() }
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            return Fail(error: NetworkingError.URLError).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Translation.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    func translate() {
        guard input != " " else {
            showAlert.toggle()
            return }
        cancellable = getTranslation(baseURL: baseURL, parameters: parameters)
            .receive(on: DispatchQueue.main)
            .catch { _ in Just(self.translation) }
            
            .sink(receiveValue: {
                    self.output = $0.data?.translations[0].translatedText ?? "error" })
    }
}





