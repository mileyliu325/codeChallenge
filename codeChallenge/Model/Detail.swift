//
//  Detail.swift
//  codeChallenge
//
//  Created by Simeng Liu on 6/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//
import Foundation
class Detail: NSObject{
    
    var display_name:String
    var id: Int
    var latitude: String
    var longitude:String
    var worker_count:Int
    var recent_activities = NSArray()
    var worker_ids:[Int]
    var profiles = NSArray()
    var tasks = NSArray()
    
    init?(json: [String: Any]) {
        guard let display_name = json["display_name"] as? String,
            let id = json["id"] as? Int,
            let latitude = json["latitude"] as? String,
            let longitude = json["longitude"] as? String,
            let worker_count = json["worker_count"] as? Int,
            let recent_activities = json["recent_activity"] as? NSArray,
            let tasks = json["tasks"] as? NSArray,
            let profiles = json["profiles"] as? NSArray,
            let worker_ids = json["worker_ids"] as? [Int]
            else {
                return nil
        }
        self.display_name = display_name
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.worker_count = worker_count
        self.recent_activities = recent_activities
        self.tasks = tasks
        self.profiles = profiles
        self.worker_ids = worker_ids
    
    }
    
    func generateActivites() ->[RecentActivity]  {
        
        var activities = [RecentActivity]()
        for i in 0..<self.recent_activities.count{
            let actDic = self.recent_activities[i] as![String:Any]
            let recent = RecentActivity.init(json:actDic)
            activities.append(recent!)
        }
        return activities
    }
    
    func generateProfiles() ->[Profile]  {
        var profilesObj = [Profile]()
        for i in 0..<self.profiles.count{
            let proDic = self.profiles[i] as![String:Any]
            let profile = Profile.init(json:proDic)
            if (profile?.insertSelfToDB())!{
                print("insert profile")
            }
            profilesObj.append(profile!)
        }
        return profilesObj
    }
    
    func generateTasks()->[Task]{
        var tasksObj = [Task]()
        for i in 0..<self.tasks.count{
            let taskDic = self.tasks[i] as![String:Any]
            let oneTask = Task.init(id: taskDic["id"] as! Int, name: taskDic["name"] as! String, poster_id: taskDic["poster_id"] as! Int)
            if (oneTask.insertSelfToDB()){
                print("insert task")
            }
            tasksObj.append(oneTask)
        }
        return tasksObj
   
    }

}

