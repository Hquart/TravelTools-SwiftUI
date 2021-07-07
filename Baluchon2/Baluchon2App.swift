import SwiftUI

@main
struct myBaluchon2App: App {
  
    @StateObject var destinationService = Destination()
    
    var body: some Scene {
        WindowGroup {
               TabView {
                DestinationView(destinationSelected: $destinationService.selection)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Preferences")
                    }.tag(0)
                WeatherView()
                       .tabItem {
                           Image(systemName: "cloud.sun.fill")
                           Text("Meteo")
                       }.tag(1)
                CurrencyView(viewModel: .init())
                       .tabItem {
                           Image(systemName: "eurosign.square")
                           Text("Conversion")
                       }.tag(2)
                TranslationView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "message.circle.fill")
                        Text("Traduction")
                    }.tag(3)
                
               }.environmentObject(destinationService)
        }
    }
}
