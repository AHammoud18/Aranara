//
//  Data.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/7/22.
//

import Foundation
import SWXMLHash  // module to parse xml
import Alamofire  //to grab xml data from url

//let url = NSURL(string: "https://raw.githubusercontent.com/AHammoud18/Aranara/test/Aranara/WeatherData.xml") //grab link of xml

class Data: Identifiable{
    var xml: XMLIndexer?
    static let shared = Data()
    var xmlToParse =    // hardcoded xml data for now until i figure out how to grab info from external source
    """
    xml data here

    """
    
    init(){
        self.xml = XMLHash.parse(xmlToParse)  // initialze parser
    }
}
        

class Fetch: Identifiable{
    var location = Data.shared.xml![""][""].element?.text  // grab location from xml
    var cloudCover = Data.shared.xml![""][""].element?.text  // grab cloud cover from xml
    var rainChance = Data.shared.xml![""][""].element?.text  // grab rain chance from xml
}

