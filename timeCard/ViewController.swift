//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBAction func startWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        startTime.text = "出勤: " + currentTime
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        finishTime.text = "退勤: " + currentTime
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
        if (segue.identifier != nil) {
            println(segue.identifier!)
        }
        if (segue.identifier! == "startTime") {
            let vc: EditTImeViewController = segue.destinationViewController as EditTImeViewController
            vc.isStartTime = true
        }
    }


}

