//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,EditTimeViewControllerDelegate {
    
    let workTimeManager = WorkTimeFileManager()
    let timer = CurrentTimeManager()

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var duringEditStartTime = false
    
    
    @IBAction func startWork(sender: AnyObject) {
        var currentTime:String = timer.getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: true)
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = timer.getCurrentTimeStr();
        updateWorkTime(currentTime, isStart: false)
    }
    
    func updateWorkTime(time :String, isStart :Bool) {
        updateTimeDisplay(time, isStart: isStart)
        workTimeManager.saveTime(timer.getCurrentDateStr(), time: time, isStart: isStart)
    }
    
    func updateTimeDisplay(time :String, isStart :Bool) {
        if isStart {
            startTime.text = "出勤: " + time
        } else {
            finishTime.text = "退勤: " + time
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TOP"
        workTimeManager.createDb()
        let times = workTimeManager.getSelectDayInfo(timer.getCurrentDateStr())

        dateLabel.text = timer.getCurrentDateStr()
        updateTimeDisplay(times[1], isStart: true)
        updateTimeDisplay(times[2], isStart: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showTable") {
            return
        }
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

