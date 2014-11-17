//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

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

    
}

class ViewController: UIViewController ,EditTimeViewControllerDelegate {
    
    var workTimeManager = WorkTimeFileManager()

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var duringEditStartTime = false
    
    @IBAction func startWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: true)
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: false)
    }
    
    func updateWorkTime(time :String, isStart :Bool) {
        updateTimeDisplay(time, isStart: isStart)
        workTimeManager.saveTime(getCurrentDateStr(), time: time, isStart: isStart)
    }
    
    func updateTimeDisplay(time :String, isStart :Bool) {
        if isStart {
            startTime.text = "出勤: " + time
        } else {
            finishTime.text = "退勤: " + time
        }
    }
    
    func loadTime(today: String)->FMResultSet {
        if(!workTimeManager.isReadyFile()){
            //ファイルがない場合はDBファイル作成
            println("create new table")
            let _db = FMDatabase(path: workTimeManager.file_path)
            let _sql = "CREATE TABLE IF NOT EXISTS timeCardDummy (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT, starttime TEXT, endtime, TEXT);"
            
            _db.open()
            
            var _result = _db.executeStatements(_sql)
            // println(_result)
            
            _db.close()
        }

        let _db = FMDatabase(path: workTimeManager.file_path)
        _db.open()
        let _sql_select = "SELECT * FROM timeCardDummy"
        var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [])

        while(_rows != nil && _rows.next()){
            var date = _rows.stringForColumn("date")
            var start = _rows.stringForColumn("starttime")
            var end = _rows.stringForColumn("endtime")
            println(date + " " + start + " ~ " + end)
            if date == getCurrentDateStr() {
                updateTimeDisplay(start, isStart: true)
                updateTimeDisplay(end, isStart: false)
            }
            
        }
        
        _db.close()
        return _rows
    }
    
    func getCurrentTimeStr()->String {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .NoStyle
        // println(dateFormatter.stringFromDate(now))
        return dateFormatter.stringFromDate(now)
    }
    
    func getCurrentDateStr()->String {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        // println(dateFormatter.stringFromDate(now))
        return dateFormatter.stringFromDate(now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dateLabel.text = getCurrentDateStr()
        
        self.navigationItem.title = "TOP"
        let rows = loadTime(getCurrentDateStr())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let vc: EditTImeViewController = segue.destinationViewController as EditTImeViewController
        if (segue.identifier! == "startTime") {
            vc.isStartTime = true
            duringEditStartTime = true
        } else {
            vc.isStartTime = false
            duringEditStartTime = false
        }
        vc.delegate = self
    }
    
    func mainViewEditTime(controller: EditTImeViewController, text: String) {
        updateWorkTime(text, isStart: duringEditStartTime)
    }

}

