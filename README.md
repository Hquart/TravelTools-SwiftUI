# Baluchon2

## Description

* Baluchon2 is an iOS iphone app realized in SwiftUI as part of my final project as a student in OpenClassRooms.
* The concept is a swiss knife for a french traveller. It features:
  * Destination choice (6 options)
  * Weather comparison between Paris and destination
  * Currency conversion 
  * Translation 

## Motivation

* This app was first realized with UIKit as an OpenClassRooms project
* The present version "Baluchon2" is a clone realized with swiftUI for the purpose of learning and discovering SwiftUI.

## Screenshots

<img width="745" alt="Screenshots_Baluchon2" src="https://user-images.githubusercontent.com/39113497/124940936-afe13980-e00a-11eb-89d2-f05231914c67.png">

## Detailed Documentation

* A more detailed documentation (in french) is available in the repository named "SupportPDF"
* The documentation describes architecture, app features and some swiftUI focus points
* It served as a support for my presentation for OpenClassRooms

## Requirements

* iOS 14
* XCode 12

## API Requirements

* A private API key is required for each service, you can get one from:
  * Weather: https://openweathermap.org
    * Paste your key in WeatherViewModel file, "parameters" variable, replace "APIKeys.openWeather"
  * Conversion: https://fixer.io
    * Paste your key in CurrencyViewModel file, "parameters" variable, replace "APIKeys.fixer"
  * Google: https://cloud.google.com/translate
    * Paste your key in TranslationViewModel file, "parameters" variable, replace "APIKeys.google"

## Credits

* OpenClassRooms DA iOS 

## License

© [Hquart](https://github.com/Hquart/)



