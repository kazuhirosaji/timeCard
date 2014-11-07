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

    @IBAction func startWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        startTime.text = "start: " + currentTime
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        var currentTime:String = getCurrentTimeStr();
        finishTime.text = "finish: " + currentTime
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

