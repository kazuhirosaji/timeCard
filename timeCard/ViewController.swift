//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,EditTimeViewControllerDelegate {

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
        if isStart {
            startTime.text = "出勤: " + time
        } else {
            finishTime.text = "退勤: " + time
        }
        saveTime(isStart)
    }

    func saveTime(isStart: Bool)->Bool {
        // /Documentsまでのパス取得方法
        let paths1 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        //let path = paths1[0].stringByAppendingPathComponent(getCurrentDateStr() + ".dat")
        let path = paths1[0].stringByAppendingPathComponent("sample.dat")
        println(path)
        
        // 保存するデータ
        var key: String
        if (isStart) {
            key = "出勤"
        } else {
            key = "退勤"
        }
        
        var saveData = [key: getCurrentTimeStr()]
        // NSKeyedArchiverクラスを使ってデータを保存する。
        // 第一引数に保存するデータ、第二引数にファイルパスを渡します。
        let success = NSKeyedArchiver.archiveRootObject(saveData, toFile: path)
        return success
    }
    
    func loadTime() {
        // /Documentsまでのパス取得方法
        let paths1 = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask, true)
        
        let path = paths1[0].stringByAppendingPathComponent("sample.dat")
        
        // NSKeyedUnarchiverクラスを使って保存したデータを読み込む。
        let saveData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as [String: String]
        
        for (key, value) in saveData {
            println("\(key)：\(value)")
        }
    }
    
    func getCurrentTimeStr()->String {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .NoStyle
        println(dateFormatter.stringFromDate(now))
        return dateFormatter.stringFromDate(now)
    }
    
    func getCurrentDateStr()->String {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        println(dateFormatter.stringFromDate(now))
        return dateFormatter.stringFromDate(now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dateLabel.text = getCurrentDateStr()
        
        self.navigationItem.title = "TOP"
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

