//
//  SQLiteManager.swift
//  codeChallenge
//
//  Created by MileyLiu on 11/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteManager: NSObject {
    
    static let instance = SQLiteManager()
    class func shareInstance() -> SQLiteManager {
        return instance
    }
    var db : OpaquePointer? = nil
    func openDB() -> Bool {
        
        let dicumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let DBPath = (dicumentPath! as NSString).appendingPathComponent("appDB.sqlite")
        let cDBPath = DBPath.cString(using: String.Encoding.utf8)
       
        if sqlite3_open(cDBPath, &db) != SQLITE_OK {
            print("Fail to p[en database")
        }
        return creatTable();
    }
    
    func creatTable() -> Bool {
        
        let createTaskTable = "CREATE TABLE IF NOT EXISTS 't_Task' ('id' INTEGAR PRIMARY KEY ,'name' TEXT NOT NULL,'poster_id' INTEGAR NOT NULL);"
       
        let createProfileTable = "CREATE TABLE IF NOT EXISTS 't_Profile' ('id' INTEGAR PRIMARY KEY,'first_name' TEXT NOT NULL,'avatar_mini_url' TEXT);"
       
        let createActivityTable = "CREATE TABLE IF NOT EXISTS 't_Activity' ('task_id' INTEGAR,'profile_id' INTEGAR,'message' TEXT);"
        
        if creatTableExecSQL(SQL_ARR: [createTaskTable,createProfileTable,createActivityTable]){
            return true
        }
        else {
            return false
            
        }
    }
   
    func creatTableExecSQL(SQL_ARR : [String]) -> Bool {
        for item in SQL_ARR {
            if execSQL(SQL: item) == false {
                return false
            }
        }
        return true
    }
    
    func execSQL(SQL : String) -> Bool {
        // SQL to C
        let cSQL = SQL.cString(using: String.Encoding.utf8)
        //ERROR
        let errmsg : UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
        if sqlite3_exec(db, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        }else{
            print("SQL EROOR \(String(describing: errmsg)),\(String(describing: cSQL))")
            
            return false
        }
    }
    
    func queryDBData(querySQL : String) -> [[String : Any]]? {
        //init OpaquePointer
        var stmt : OpaquePointer? = nil
        
        if querySQL.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            let cQuerySQL = (querySQL.cString(using: String.Encoding.utf8))!
            
            // 1> para1:database
            // 2> para2:querySql
            // 3> para3:length -1
            // 4> para4:OpaquePointer
            
            if sqlite3_prepare_v2(db, cQuerySQL, -1, &stmt, nil) == SQLITE_OK {
                
                var queryDataArrM = [[String : Any]]()
                while sqlite3_step(stmt) == SQLITE_ROW {
                   
                    let columnCount = sqlite3_column_count(stmt)
                    
                    var dict = [String : Any]()
                    for i in 0..<columnCount {
                        
                        let cKey = sqlite3_column_name(stmt, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        let cValue = sqlite3_column_text(stmt, i)
                        let value =  String(cString:cValue!)
                        dict[key] = value as Any
                       
                    }
                    queryDataArrM.append(dict)
                }
                return queryDataArrM
            }
        }
        return nil
    }
}
