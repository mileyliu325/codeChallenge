//
//  Profile.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import Foundation
class Profile: NSObject {
   
    var id : Int
    var avatar_mini_url: String
    var first_name : String
    var profileDescription: String
    var rating :Double
    var location_id :Int
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let first_name = json["first_name"] as? String,
            let description = json["description"] as? String,
            let avatar_mini_url = json["avatar_mini_url"] as? String,
            let rating = json["rating"] as? Double,
            let location_id = json["location_id"] as? Int
            
            else {
                return nil
        }
        
        self.id = id
        self.first_name = first_name
        self.profileDescription = description
        self.avatar_mini_url = avatar_mini_url
        self.rating = rating
        self.location_id = location_id
    }
    
    
    func insertSelfToDB() ->Bool{
        
        let insertSQL = "INSERT OR REPLACE INTO 't_Profile' (id,first_name,avatar_mini_url) VALUES (\(id),'\(first_name)','\(avatar_mini_url)');"
       
        if SQLiteManager.shareInstance().execSQL(SQL: insertSQL) {
            print("insert profile to db")
            return true
        }else{
            return false
        }
    }
    
    
    
    
    
    
}

