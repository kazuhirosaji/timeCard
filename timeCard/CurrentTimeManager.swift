//
//  CurrentTimeManager.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/20.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import Foundation

class CurrentTimeManager {
    
    init() {}
    
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
}