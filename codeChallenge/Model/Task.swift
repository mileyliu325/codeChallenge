
//
//  Task.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import Foundation
class Task: NSObject {
    var name : String
    var id : Int
    var poster_id :Int
    
    init(id: Int, name:String,poster_id: Int) {
        self.id = id
        self.name = name
        self.poster_id = poster_id
    }
    
    func insertSelfToDB() ->Bool{
        
        let insertSQL = "INSERT OR REPLACE INTO 't_Task' (id,name,poster_id) VALUES (\(id),'\(name)',\(poster_id));"
        
        if SQLiteManager.shareInstance().execSQL(SQL: insertSQL) {
            print("插入Task数据成功")
            return true
        }else{
            
            return false
        }
    }
   
}
