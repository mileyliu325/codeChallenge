//
//  RecentActivity.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//
import Foundation

class RecentActivity: Codable {
    var task_id :Int
    var profile_id : Int
    var message: String
    var created_at : String
    var event: String
    
    init?(json: [String: Any]) {
        guard let task_id = json["task_id"] as? Int,
            let profile_id = json["profile_id"] as? Int,
            let message = json["message"] as? String,
            let created_at = json["created_at"] as? String,
            let event = json["event"] as? String
            
            else {
                return nil
        }
        
        self.task_id = task_id
        self.profile_id = profile_id
        self.message = message
        self.created_at = created_at
        self.event = event
    }
    
    func getTaskName() -> String{
        
        var taskNameString = ""
        let querySQL = "SELECT id,poster_id,name FROM 't_Task' WHERE id = \(task_id)"
        let taskName = SQLiteManager.shareInstance().queryDBData(querySQL: querySQL)
        let nameDic = taskName![0] as! [String:Any]
        
        taskNameString = nameDic["name"] as! String
        return taskNameString
    }
    
    func getProfile() -> (name:String,url:String){
        
        var profileNameString = ""
        var profileUrlString = ""
        let querySQL = "SELECT id,first_name,avatar_mini_url FROM 't_Profile' WHERE id = \(profile_id)"
        let profileName = SQLiteManager.shareInstance().queryDBData(querySQL: querySQL)
        let profileDic = profileName![0] as! [String:Any]
        
        profileNameString = profileDic["first_name"] as! String
        profileUrlString = profileDic["avatar_mini_url"] as! String
        return (name:profileNameString, url:profileUrlString)
        
    }

}
