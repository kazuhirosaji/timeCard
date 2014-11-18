//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

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
        let times = workTimeManager.loadTime(getCurrentDateStr())
        updateTimeDisplay(times[0], isStart: true)
        updateTimeDisplay(times[1], isStart: false)
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

