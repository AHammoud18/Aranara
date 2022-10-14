//
//  Data.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/7/22.
//

import Foundation
import SWXMLHash  // module to parse xml
import Alamofire //to grab xml data from url
import UIKit

class Data: ObservableObject{
    //var xml: XMLIndexer?
    @Published var elements: String?
    let url = URL(string: "https://raw.githubusercontent.com/AHammoud18/Aranara/test/Aranara/WeatherData.xml")! //grab link of xml
    // fucntion to get data from url
    //var location: String?
    static let shared = Data()
    func getData(){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            let xml = XMLHash.parse(data!)
            // grab tags from XML and apply to each variable
            let location = xml["Michigan_Weather"]["location"].element?.text
            self.elements = location
        }
        task.resume()
            //self.location = xml["Michigan_Weather"]["location"].element?.text
        }
}
