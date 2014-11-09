//
//  EditTimeViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/08.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import Foundation
import UIKit

protocol EditTimeViewControllerDelegate{
    func mainViewEditTime(controller:EditTImeViewController,text:String)
}

class EditTImeViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var isStartTime = false
    
    var delegate:EditTimeViewControllerDelegate? = nil
    
    
    @IBAction func onEditTIme(sender: UIDatePicker) {
        let editTime = sender.date
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .NoStyle
        println(dateFormatter.stringFromDate(editTime))
        dateLabel.text = dateFormatter.stringFromDate(editTime)
        if (delegate != nil) {
            delegate!.mainViewEditTime(self, text: dateFormatter.stringFromDate(editTime))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (isStartTime) {
            dateLabel.text = "編集(出勤時間)";
        } else {
            dateLabel.text = "編集(退勤時間)";
        }
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.datePickerMode = UIDatePickerMode.Time
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

