//
//  WeatherView.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 08/02/2021.
//

import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var destination: Destination
    /////////////////////////////////// BODY ////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
                VStack {
                    /////////////////////////////////////////  LOGO  //////////////////////////////
                    Image("myBaluchon")
                        .position(x: 190, y: 80)
                    Spacer(minLength: 50)
                    /////////////////////////////////////////  HOME CITY //////////////////////////////
                    WeatherBlock(viewModel: .init(destination: destination.selection, homeCity: true))
                        .frame(width: 300, height: 150, alignment: .center)
                    Spacer(minLength: 50)
                    ////////////////////////////   DESTINATION   /////////////////////////////////////////////
                    WeatherBlock(viewModel: .init(destination: destination.selection, homeCity: false))
                        .frame(width: 300, height: 150, alignment: .center)
                    ///////////////////////////////////////////////////////////////////////////////////////////////////
                    Spacer(minLength: 70)
                }
                .navigationBarTitle("Météo")
        }
    }
}
///////////////////////////////////////// PREVIEW ///////////////////////////////////////////////////////////////////////
struct WeatherView_Previews: PreviewProvider {
  
    static var previews: some View {
        WeatherView()
            .environmentObject(Destination())
    }
    
}



