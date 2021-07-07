//
//  HideKeyboard.swift
//  Baluchon2
//
//  Created by Naji Achkar on 21/06/2021.
//

import Foundation
import SwiftUI

// no modifier available to hide keyboard(), so we have to use this extension for the moment:
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
