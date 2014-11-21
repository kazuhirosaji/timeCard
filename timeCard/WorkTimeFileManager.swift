//
//  WorkTimeFileManager.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/18.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import Foundation

class WorkTimeFileManager {
    var file_path:String = ""
    let file_name:NSString = "dummy5.db"
    let fileManager:NSFileManager = NSFileManager.defaultManager()
    
    init() {
        let _dir:AnyObject = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)[0]
        file_path = _dir.stringByAppendingPathComponent(file_name)
        
        //println(file_path)
    }

    func createDb() {
        if(!isReadyFile()){
            //ファイルがない場合はDBファイル作成
            println("create new table")
            let _db = FMDatabase(path: file_path)
            let _sql = "CREATE TABLE IF NOT EXISTS timeCardDummy (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT, starttime TEXT, endtime, TEXT);"
            
            _db.open()
            
            var _result = _db.executeStatements(_sql)
            // println(_result)
            
            _db.close()
        }
    }
    
    func isReadyFile()->Bool {
        return fileManager.fileExistsAtPath(file_path)
    }
    
    func saveTime(date:String, time :String, isStart: Bool)->Bool {
        if (isReadyFile()) {
            //ファイルが存在する場合
            let _db = FMDatabase(path: file_path)
            
            _db.open()
            let _sql_select = "SELECT * FROM timeCardDummy WHERE date = ?"
            var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [date])
            
            if (_rows != nil && _rows.next()) {
                var _sql_update = ""
                if (isStart) {
                    _sql_update = "UPDATE timeCardDummy SET starttime = :TIME WHERE date = :DATE;"
                } else {
                    _sql_update = "UPDATE timeCardDummy SET endtime = :TIME WHERE date = :DATE;"
                }
                _db.executeUpdate(_sql_update, withParameterDictionary: ["TIME":time, "DATE": date])
            } else {
                let _sql_insert = "insert into timeCardDummy (date, starttime, endtime) values (:DATE, :START, :END);"
                var start:String = "--:--:--"
                var end:String = "--:--:--"
                if (isStart) {
                    start = time
                } else {
                    end = time
                }
                var _result_insert = _db.executeUpdate(_sql_insert,
                    withParameterDictionary: ["DATE":date, "START":start, "END":end])
                println(_result_insert)
            }
            _db.close()
            
        } else {
            println("file not exist")
        }
        return true
    }
    
    func loadTime(today: String)->[[String]] {
        if(!isReadyFile()){
            //ファイルがない場合
            return [["", "", ""]]
        }
        
        let _db = FMDatabase(path: file_path)
        _db.open()
        let _sql_select = "SELECT * FROM timeCardDummy"
        var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [])
        var index = 0
        var dateArray:[[String]] = []

        while(_rows != nil && _rows.next()){
            dateArray.append(["", "", ""])
            dateArray[index][0] = _rows.stringForColumn("date")
            dateArray[index][1] = _rows.stringForColumn("starttime")
            dateArray[index][2] = _rows.stringForColumn("endtime")
            index++
        }
        
        _db.close()
        return dateArray
    }
    
    func getSelectDayInfo(selectDate: String)->[String] {
        var array = [selectDate, "--:--:--", "--:--:--"]
        if(!isReadyFile()){
            //ファイルがない場合
            return array
        }
        
        let _db = FMDatabase(path: file_path)
        _db.open()
        let _sql_select = "SELECT * FROM timeCardDummy WHERE date = ?"
        var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [selectDate])
        
        if(_rows != nil && _rows.next()){
            array[0] = _rows.stringForColumn("date")
            array[1] = _rows.stringForColumn("starttime")
            array[2] = _rows.stringForColumn("endtime")
        }
        
        _db.close()
        return array
    }
    
}
