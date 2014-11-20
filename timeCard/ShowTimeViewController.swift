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
    var texts:[[String]] = [["","",""]]
    
    // セルの行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//texts.count
    }
    
    // セルの内容を変更
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value2 , reuseIdentifier: "Cell")

        
        cell.textLabel.text = texts[0][0]
        cell.detailTextLabel?.text = texts[0][1] + " ~ " + texts[0][2];
        return cell
    }
    
    override func viewDidLoad() {
        texts = workTimeManager.loadTime(timer.getCurrentDateStr())
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}