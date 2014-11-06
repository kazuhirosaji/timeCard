//
//  ViewController.swift
//  timeCard
//
//  Created by 佐治和弘 on 2014/11/04.
//  Copyright (c) 2014年 kazuhirosaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkTimeLabel: UILabel!
    @IBAction func startWork(sender: AnyObject) {
        checkTimeLabel.text = "working"
    }
    
    @IBAction func finishWork(sender: AnyObject) {
        checkTimeLabel.text = "finished"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

