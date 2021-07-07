//
//  DestinationView.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 08/02/2021.
//

import SwiftUI
import Combine

struct DestinationView: View {

    @Binding var destinationSelected: Int
    //////////////////////////////  BODY  /////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image("myBaluchon")
                        .position(x: 190, y: 80)
                    Text("Bienvenue Voyageur")
                    Text("choisissez votre destination")
                    //////////////////////////////   PICKER  /////////////////////////////////////////////////
                    Picker(selection: $destinationSelected,
                           label: Text("choisissez votre destination")) {
                        ForEach(0 ..< Destination.name.count) {
                            Text(Destination.name[$0]).tag(destinationSelected)
                        }
                    }
                    Spacer()
                    //////////////////////////////  IMAGE  /////////////////////////////////////////////////
                    Image("\(Destination.name[destinationSelected])")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.95, maxHeight: 200)
                        .padding(.top)
                    Spacer()
                }
                .navigationBarTitle("Destination")
            }
        }
    }
}
//////////////////////////////   PREVIEW  /////////////////////////////////////////////////
struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(destinationSelected: .constant(1))
    }
}
