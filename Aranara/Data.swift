//
//  Data.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/7/22.
//

import Foundation
import SWXMLHash  // module to parse xml
import Alamofire //to grab xml data from url
import CoreLocation
import MapKit
import SwiftyJSON


class Data: NSObject, ObservableObject, CLLocationManagerDelegate{
    // create variables to be used in ContentView
    @Published var location: String?
    @Published var weather: String?
    @Published var temperature: String?
    @Published var state: String?
    @Published var longCords: Double?
    @Published var latCords: Double?
    @Published var weatherImg: String?
    
    static let shared = Data()
    
    // this will get the user's long and lat coords with consent
    func getLocation(){
        let locationManager = CLLocationManager()
        if (CLLocationManager.locationServicesEnabled())
        {
            //locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.longCords = locationManager.location?.coordinate.longitude
            self.latCords = locationManager.location?.coordinate.latitude
        }
    }

    // this function utilized SWXMLHash to retrieve data from xml files online
    func getWeatherStatus(){ // fucntion to get weather data from xml
        let url = URL(string: "https://forecast.weather.gov/MapClick.php?lat=\(self.latCords ?? 0.01)&lon=\(self.longCords ?? 0.01)&unit=0&lg=english&FcstType=dwml")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            let xml = XMLHash.parse(data!)
            let currentWeather = xml["dwml"]["data"][1]["parameters"]["weather"]["weather-conditions"][0].element?.attribute(by: "weather-summary")?.text
            self.weather = currentWeather
            
        }
        task.resume()
    }
    
    // http://api.airvisual.com/v2/nearest_city?lat=(latString)&lon=(longString)&key=629d2dc4-87a1-4e04-9949-02f86bebf00e
    // this link will get the nearest location from latitude and longitutde cords, using my personal API key^^^
    
    // this function loads data from an API, may look for API framework
    func loadAPIData(){
        AF.request("https://api.airvisual.com/v2/nearest_city?lat=\(self.latCords ?? 0.01)&lon=\(self.longCords ?? 0.01)&key=629d2dc4-87a1-4e04-9949-02f86bebf00e").responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.location = json["data"]["city"].string
                self.state = json["data"]["state"].string
                self.weatherImg = json["data"]["current"]["weather"]["ic"].string
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

    
