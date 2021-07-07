//
//  WeatherBlock.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 11/06/2021.

import SwiftUI

struct WeatherBlock: View {
    
    @EnvironmentObject var destination: Destination
    
    @ObservedObject var viewModel: WeatherViewModel
    //////////////////////////////  BODY  /////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer(minLength: 20)
                    Text(viewModel.homeCity ? "Paris" : Destination.name[destination.selection])
                        .font(.custom("Arial", size: 25))
                        .foregroundColor(.white).bold()
                    Spacer()
                    Text(viewModel.temp)
                        .font(.custom("Arial", size: 25))
                        .foregroundColor(.appOrange).bold()
                    Spacer()
                }
                Spacer(minLength: geometry.size.width * 0.2)
                VStack {
                    Spacer()
                    Image(viewModel.image)
                        .resizable()
                        .frame(maxWidth: geometry.size.width * 0.3, maxHeight: 120)
                    Spacer()
                    Text(viewModel.conditions)
                        .font(.custom("Arial", size: 20))
                        .foregroundColor(.black).italic()
                    Spacer(minLength: 35)
                }
                Spacer()
            }
            .onAppear { viewModel.updateWeather() }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGreen, lineWidth: 5))
            .background(Color.appGreen)
            
            Spacer()
        }
    }
}
//////////////////////////////  PREVIEW  /////////////////////////////////////////////////
struct WeatherBlock_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBlock(viewModel: WeatherViewModel(temp: "10", image: "02d", conditions: "cloudy", homeCity: false))
            .environmentObject(Destination())
            .frame(width: 300, height: 150, alignment: .center)

    }
}
