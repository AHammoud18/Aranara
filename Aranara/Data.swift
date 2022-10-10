//
//  Data.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/7/22.
//

import Foundation
import SWXMLHash

let url = NSURL(string: "https://raw.githubusercontent.com/AHammoud18/Aranara/test/Aranara/WeatherData.xml") //grab link of xml

class Data: Identifiable{
    
    let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
        // parse xml file
        if data != nil{
            let feed = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            let xml = XMLHash.lazy(feed)
            
            /*var locationName = xml["Michigan_Weather"]["location"].element!.text
            var cloudCoverage = xml["Michigan_Weather"]["cloud_coverage"].element!.text
            var rain = xml["Michigan_Weather"]["rain_chance"].element!.text*/
            
            /*var locationName: String
            var cloudCoverage: String
            var rain: String*/
            
            /*item.location = xml["Michigan_Weather"]["location"].element!.text
            item.cloudCover = xml["Michigan_Weather"]["cloud_coverage"].element!.text
            item.rainChance = xml["Michigan_Weather"]["cloud_coverage"].element!.text*/
        }
        
    }
}

