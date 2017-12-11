//
//  Location.swift
//  codeChallenge
//
//  Created by Simeng Liu on 6/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//
import Foundation
struct Location: Codable {
    
    var display_name: String
    var id : Int
    var latitude : String
    var longitude : String
    
    
    init?(json: [String: Any]) {
        guard let display_name = json["display_name"] as? String,
            let id = json["id"] as? Int,
            let latitude = json["latitude"] as? String,
            let longitude = json["longitude"] as? String else {
                return nil
        }
        self.display_name = display_name
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
    
//    static func endpointForID(_ id: Int) -> String {
//        return "\(urlScheme)/location\(id).json"
//    }
    
    
//    init(  display_name : String,
//           id : Int,
//           latitude : String,
//           longitude : String) {
//
//        self.display_name = display_name
//        self.id = id
//        self.latitude = latitude
//        self.longitude = longitude
//
//    }
    
//    init(jsonObject: AnyObject) {
//        self.display_name = jsonObject
//        
//    }
    
//    init(JSONString: String) {
//        super.init()
//
//        var error : NSError?
//        let JSONData = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: false)
//
//        let JSONDictionary : Dictionary  = try JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) as Dictionary
//
//
//
//
//        // Loop
//        for (key, value) in JSONDictionary {
//            let keyName = key as String
//            let keyValue: String = value as String
//
//            // If property exists
//            if (self.respondsToSelector(NSSelectorFromString(keyName))) {
//                self.setValue(keyValue, forKey: keyName)
//            }
//        }
//        // Or you can do it with using
//        // self.setValuesForKeysWithDictionary(JSONDictionary)
//        // instead of loop method above
//    }
    
}


