//
//  ShowTimeViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/19.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import Foundation
import UIKit

class ShowTimeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // セルに表示するテキスト
    let workTimeManager = WorkTimeFileManager()
    var timer = CurrentTimeManager()
    var texts = [""]
    
    // セルの行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    // セルの内容を変更
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel.text = texts[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        texts = workTimeManager.getSelectDayInfo(timer.getCurrentDateStr());
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}