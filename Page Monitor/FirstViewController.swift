//
//  FirstViewController.swift
//  Page Monitor
//
//  Created by Yoshio Fujimoto on 12/8/14.
//  Copyright (c) 2014 ThinkFuji. All rights reserved.
//

import UIKit

var pages:[String] = []
class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell();
        
        return cell
    }

}

