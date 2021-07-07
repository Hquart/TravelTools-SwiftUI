//
//  Translation.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 11/02/2021.
//


import Foundation

struct Translation: Decodable {
    let data: DataClass?
    
    init(data: DataClass? = nil) {
        self.data = data
    }
}
////////////////////////////////////////////////////////////////////////////////////
struct DataClass: Decodable {
    let translations: [TranslationElement]
}
////////////////////////////////////////////////////////////////////////////////////
struct TranslationElement: Decodable {
    let translatedText: String
}


