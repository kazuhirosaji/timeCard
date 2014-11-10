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
        startTime.text = "出勤: " + currentTime

        // /Documentsまでのパス取得方法
        let paths1 = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask, true)
        
        let path = paths1[0].stringByAppendingPathComponent("sample.dat")
        
        println(path)
        // 保存するデータ
        var user = ["Name": "saji", "Comment": "hello"]
        // NSKeyedArchiverクラスを使ってデータを保存する。
        // 第一引数に保存するデータ、第二引数にファイルパスを渡します。
        let success = NSKeyedArchiver.archiveRootObject(user, toFile: path)
        if success {
            println("保存に成功")
        }
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        finishTime.text = "退勤: " + currentTime

        // /Documentsまでのパス取得方法
        let paths1 = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask, true)
        
        let path = paths1[0].stringByAppendingPathComponent("sample.dat")
        
        // NSKeyedUnarchiverクラスを使って保存したデータを読み込む。
        let user = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as [String: String]
        
        for (key, value) in user {
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
        if (duringEditStartTime) {
            startTime.text = "出勤: " + text
        } else {
            finishTime.text = "退勤: " + text
        }
    }

}

