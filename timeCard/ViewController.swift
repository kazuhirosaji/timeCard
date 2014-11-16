//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,EditTimeViewControllerDelegate {

    var file_path:String = ""

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var duringEditStartTime = false
    let fileManager:NSFileManager = NSFileManager.defaultManager()
    
    @IBAction func startWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: true)
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: false)
    }
    
    func updateWorkTime(time :String, isStart :Bool) {
        if isStart {
            startTime.text = "出勤: " + time
        } else {
            finishTime.text = "退勤: " + time
        }
        saveTime(isStart)
    }
    
    func initFileSetting() {
        let _dbfile:NSString = "dummy4.db"
        let _dir:AnyObject = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)[0]
        file_path = _dir.stringByAppendingPathComponent(_dbfile)
        
        //println(file_path)
    }

    func saveTime(isStart: Bool)->Bool {
        if (fileManager.fileExistsAtPath(file_path)) {
            //ファイルが存在する場合
            let _db = FMDatabase(path: file_path)

            _db.open()
            let _sql_select = "SELECT * FROM timeCardDummy WHERE date = ?"
            var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [getCurrentDateStr()])
            
            if (_rows != nil) {
                let _sql_update = "UPDATE timeCardDummy SET starttime = :START WHERE date = :DATE;"
                _db.executeUpdate(_sql_update, withParameterDictionary: ["START":getCurrentTimeStr(), "DATE": getCurrentDateStr()])
            } else {
                let _sql_insert = "insert into timeCardDummy (date, starttime, endtime) values (?, ?, ?);"
                var _result_insert = _db.executeUpdate(_sql_insert,
                    withArgumentsInArray: [getCurrentDateStr(), getCurrentTimeStr(), getCurrentTimeStr()])
                println(_result_insert)
            }
            _db.close()
            
        } else {
            println("file not exist")
        }
        return true
    }

    
    func loadTime() {
        if(!fileManager.fileExistsAtPath(file_path)){
            //ファイルがない場合はDBファイル作成
            let _db = FMDatabase(path: file_path)
            let _sql = "CREATE TABLE timeCardDummy (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT, starttime TEXT, endtime, TEXT);"
            
            _db.open()
            
            var _result = _db.executeStatements(_sql)
            // println(_result)
            
            _db.close()
        } else {
            let _db = FMDatabase(path: file_path)
            _db.open()
            let _sql_select = "SELECT * FROM timeCardDummy"
            var _rows = _db.executeQuery(_sql_select, withArgumentsInArray: [])
            
            
            while(_rows != nil && _rows.next()){
                var date = _rows.stringForColumn("date")
                var starttime = _rows.stringForColumn("starttime")
                println(date + " " + starttime)
            }
            
            _db.close()
        }
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
        initFileSetting()
        loadTime()
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

