//
//  EditTimeViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/08.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import Foundation
import UIKit

class EditTImeViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func onEditTIme(sender: UIDatePicker) {
        let editTime = sender.date
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .NoStyle
        println(dateFormatter.stringFromDate(editTime))
        dateLabel.text = dateFormatter.stringFromDate(editTime)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.datePickerMode = UIDatePickerMode.Time
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

